import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_error_message.dart';
import 'package:video_to_audio/core/presentation/widgets/loading_popup.dart';
import 'package:video_to_audio/core/presentation/widgets/spacers/horizontal_spacers.dart';
import 'package:video_to_audio/modules/home/presentation/widgets/video_card.dart';

import 'package:video_to_audio/modules/home/presentation/bloc/downloader_bloc.dart' as downloader;
import 'package:video_to_audio/modules/settings/presentation/bloc/setting_bloc.dart' as setting;
import 'package:video_to_audio/modules/settings/presentation/screens/setting.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetUrlData extends StatefulWidget {
  const GetUrlData({Key? key}) : super(key: key);
  @override
  State<GetUrlData> createState() => _GetUrlDataState();
}

class _GetUrlDataState extends State<GetUrlData> {
  final _urlTextController = TextEditingController();
  VideoData? _videoData;
  bool _hasPermissions = false;
  String _directory = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    _getSaveDirectory();
    _urlTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<downloader.DownloaderBloc, downloader.DownloaderState>(
          listener: (context, state) {
            if (state is downloader.LoadingStart) {
              AlertLoading.show(context);

              setState(() {
                _videoData = null;
                _errorMessage = '';
              });
            }

            if (state is downloader.LoadingStop) {
              AlertLoading.hide(context);
            }

            if (state is downloader.HasVideoData) {
              setState(() {
                _videoData = state.videoData;
              });

              Future.delayed(const Duration(seconds: 0)).then((_) {
                _showBottomSheet(state.videoData);
              });
            }

            if (state is downloader.AudioDownloadingSuccess) {
              setState(() {
                _errorMessage = '';
              });
            }

            if (state is downloader.NoVideoData) {
              setState(() {
                _videoData = null;
              });
            }

            if (state is downloader.HasPermission) {
              setState(() {
                _hasPermissions = true;
              });
              _downloadAudio();
            }

            if (state is downloader.HasDirectoryData) {
              setState(() {
                _directory = state.directory;
              });
            }

            if (state is downloader.DownloaderError) {
              setState(() {
                _errorMessage = state.error.toString();
              });
            }

            if (state is downloader.AudioDownloadingError) {
              setState(() {
                _errorMessage = state.error.toString();
              });
            }

            if (state is downloader.DirectoryError) {
              setState(() {
                _errorMessage = state.error.toString();
              });
            }
          },
        ),
        BlocListener<setting.SettingBloc, setting.SettingState>(
          listener: (context, state) {
            if (state is setting.HasDirectoryData) {
              _getSaveDirectory();
            }
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.greetings,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: UIConst.textLight,
                ),
          ),
          const HorizontalSpacer16(),
          Text(
            AppLocalizations.of(context)!.messages,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: UIConst.textLight,
                ),
          ),
          const HorizontalSpacer16(),
          TextFormField(
            controller: _urlTextController,
            decoration: InputDecoration(
              filled: true,
              fillColor: UIConst.textLight,
              hintText: AppLocalizations.of(context)!.hint_link,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: UIConst.textMid,
                  ),
              prefixIcon: Icon(
                Icons.link_sharp,
                color: UIConst.textMid,
              ),
              suffixIcon: _urlTextController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _urlTextController.clear();
                      },
                      icon: Icon(
                        Icons.close,
                        color: UIConst.textMid,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: UIConst.borderRadiusWidget,
                borderSide: BorderSide.none,
              ),
            ),
            onFieldSubmitted: (str) =>
                str.isNotEmpty && _validateUrl(str) ? _getUrlData(str) : null,
          ),
          CustomErrorMessage(
            message: _errorMessage,
          ),
        ],
      ),
    );
  }

  _showBottomSheet(VideoData videoData) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: UIConst.colorBottomSheetBackground,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: UIConst.radiusWidget,
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: _showVideoData(),
        );
      },
    );
  }

  Widget _showVideoData() {
    if (_videoData != null) {
      return VideoCard(
        videoData: _videoData!,
        onTapDownload: () async {
          if (_hasPermissions) {
            _downloadAudio();
          } else {
            _askForPermissions();
          }
        },
        onTapOpen: () async {
          if (_directory.isNotEmpty) {
            _openDownloadedFile();
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }

  bool _validateUrl(String? value) {
    return Uri.parse(value!).isAbsolute;
  }

  void _getUrlData(String url) {
    context.read<downloader.DownloaderBloc>().add(downloader.OnGetUrlData(url));
  }

  _askForPermissions() {
    context.read<downloader.DownloaderBloc>().add(downloader.OnRequestPermission());
  }

  _getSaveDirectory() {
    context.read<downloader.DownloaderBloc>().add(downloader.OnGetDirectory());
  }

  _downloadAudio() {
    if (_directory.isNotEmpty && _videoData != null) {
      context.read<downloader.DownloaderBloc>().add(downloader.OnDownloadAudioWithProgress(
          _videoData!, _directory, _videoData!.audioManifest!.filename!));
    } else {
      Setting.navigateTo(context);
    }
  }

  _openDownloadedFile() {
    context.read<downloader.DownloaderBloc>().add(downloader.OnOpenDownloadedFile(
        directory: _directory, filename: _videoData!.audioManifest!.filename!));
  }
}
