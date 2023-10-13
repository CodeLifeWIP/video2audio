import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_error_message.dart';
import 'package:video_to_audio/core/presentation/widgets/loading_popup.dart';
import 'package:video_to_audio/core/presentation/widgets/spacers/horizontal_spacers.dart';
import 'package:video_to_audio/modules/home/presentation/bloc/downloader_bloc.dart';
import 'package:video_to_audio/modules/home/presentation/widgets/video_card.dart';
import 'package:video_to_audio/modules/settings/presentation/screens/setting.dart';

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
    return BlocListener<DownloaderBloc, DownloaderState>(
      listener: (context, state) {

        if (state is LoadingStart) {
          AlertLoading.show(context);

          setState(() {
            _videoData = null;
            _errorMessage = '';
          });
        }

        if (state is LoadingStop) {
          AlertLoading.hide(context);
        }

        if (state is HasVideoData) {
          setState(() {
            _videoData = state.videoData;
          });

          Future.delayed(const Duration(seconds: 0)).then((_) {
            _showBottomSheet(state.videoData);
          });
        }

        if(state is AudioDownloadingSuccess){
          setState(() {
            _errorMessage = '';
          });
        }

        if (state is NoVideoData) {
          setState(() {
            _videoData = null;
          });
        }


        if (state is HasPermission) {
          setState(() {
            _hasPermissions = true;
          });
          _downloadAudio();
        }

        if (state is HasDirectoryData) {
          setState(() {
            _directory = state.directory;
          });
        }

        if (state is DownloaderError) {
          setState(() {
            _errorMessage = state.error.toString();
          });
        }

        if (state is AudioDownloadingError) {
          setState(() {
            _errorMessage = state.error.toString();
          });
        }

        if (state is DirectoryError) {
          setState(() {
            _errorMessage = state.error.toString();
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: UIConst.textLight,
                ),
          ),
          const HorizontalSpacer16(),
          Text(
            "Turn your video into audio",
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
              hintText: "Link goes here",
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
          CustomErrorMessage(message: _errorMessage,),
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
      );
    } else {
      return const SizedBox();
    }
  }

  bool _validateUrl(String? value) {
    return Uri.parse(value!).isAbsolute;
  }

  String _createValidFilename(String videoName) {
    return videoName;
  }

  void _getUrlData(String url) {
    context.read<DownloaderBloc>().add(OnGetUrlData(url));
  }

  _askForPermissions() {
    context.read<DownloaderBloc>().add(OnRequestPermission());
  }

  _getSaveDirectory() {
    context.read<DownloaderBloc>().add(OnGetDirectory());
  }

  _downloadAudio() {
    if (_directory!.isNotEmpty && _videoData != null) {
      // context.read<DownloaderBloc>().add(OnDownloadAudio(_videoData!,
      //     _directory!, _createValidFilename(_videoData!.videoId!.toString())));

      context.read<DownloaderBloc>().add(OnDownloadAudioWithProgress(_videoData!,
          _directory!, _createValidFilename(_videoData!.videoId!.toString())));
    } else {
      Setting.navigateTo(context);
    }
  }

}
