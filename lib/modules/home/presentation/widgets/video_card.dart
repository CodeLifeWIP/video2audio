import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/download_button2.dart' as DB2;
import 'package:video_to_audio/core/presentation/widgets/spacers/horizontal_spacers.dart';
import 'package:video_to_audio/modules/home/presentation/bloc/downloader_bloc.dart';

class VideoCard extends StatefulWidget {
  final VideoData videoData;
  final VoidCallback onTapDownload;

  const VideoCard(
      {Key? key, required this.videoData, required this.onTapDownload})
      : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConst.paddingBottomSheet,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width +
                        UIConst.paddingScreen.horizontal) /
                    2,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(
                            widget.videoData.thumbnails?.standardRes ?? '',
                            width: 200.0)
                        .image,
                    fit: BoxFit.cover,
                  ),
                  // border: Border.all(color: Colors.white),
                  borderRadius: UIConst.borderRadiusWidget,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: widget.onTapDownload,
                          child: BlocBuilder<DownloaderBloc, DownloaderState>(
                            builder: (context, state) {
                              var status = DB2.DownloadStatus.notDownloaded;
                              var progress = 0.0;

                              if (state is AudioIsDownloading) {
                                status = DB2.DownloadStatus.fetchingDownload;
                              }

                              if (state is AudioDownloadingSuccess) {
                                status = DB2.DownloadStatus.downloaded;
                              }

                              if (state is AudioDownloadingError) {
                                status = DB2.DownloadStatus.notDownloaded;
                              }

                              if(state is AudioDownloadingHasProgress){
                                status = DB2.DownloadStatus.downloading;
                                progress = double.parse(state.message);

                                if(progress == 100){
                                  status = DB2.DownloadStatus.downloaded;
                                }
                              }

                              return DB2.DownloadButton2(
                                status: status,
                                downloadProgress: progress,
                                onDownload: widget.onTapDownload,
                                onCancel: () {},
                                onOpen: () {
                                  Navigator.pop(context);
                                },
                              );

                            },
                          ),
                        ),
                        const HorizontalSpacer8(),
                        _displaySize(widget.videoData.audioManifest?.sizes),
                        const HorizontalSpacer2(),
                        _displayDuration(widget.videoData.duration ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const HorizontalSpacer8(),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.videoData.title ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const HorizontalSpacer4(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.videoData.author ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: UIConst.textLight,
                      ),
                ),
              ),
              const HorizontalSpacer16(),
              Text(
                widget.videoData.description ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: UIConst.textLight,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _displayDuration(String duration) {
    return Text(
      duration.substring(0, duration.indexOf('.')),
      style: TextStyle(color: UIConst.textLight),
    );
  }

  Widget _displaySize(Sizes? sizes) {
    String? displaySize = '0.00 B';

    if (sizes != null && sizes.inGigaBytes! > .99) {
      displaySize = "${sizes.inGigaBytes?.toStringAsPrecision(3)} GB";
    } else if (sizes != null && sizes.inMegaBytes! > .99) {
      displaySize = "${sizes.inMegaBytes?.toStringAsPrecision(3)} MB";
    } else if (sizes != null && sizes.inKiloByte! > .99) {
      displaySize = "${sizes.inKiloByte?.toStringAsPrecision(3)} KB";
    } else if (sizes != null && sizes.inBytes! > 0.00) {
      displaySize = "${sizes.inBytes?.toStringAsPrecision(3)} B";
    }

    return Text(
      displaySize!,
      style: TextStyle(color: UIConst.textLight),
    );
  }
}
