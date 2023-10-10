import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';

enum DownloadStatus {
  fetchingDownload,
  downloading,
  downloaded,
  notDownloaded,
}

class DownloadButton extends StatelessWidget {
  final DownloadStatus status;
  final double downloadProgress;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onOpen;
  final Duration transitionDuration;

  const DownloadButton(
      {Key? key,
      required this.status,
      this.downloadProgress = 0,
      required this.onDownload,
      required this.onCancel,
      required this.onOpen,
      this.transitionDuration = const Duration(milliseconds: 200)})
      : super(key: key);

  bool get _isDownloading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  bool get _isNotDownloaded => status == DownloadStatus.notDownloaded;

  void _onPressed() {
    switch (status) {
      case DownloadStatus.notDownloaded:
        onDownload();
        break;
      case DownloadStatus.fetchingDownload:
        // do nothing.
        break;
      case DownloadStatus.downloading:
        onCancel();
        break;
      case DownloadStatus.downloaded:
        onOpen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          ButtonShapeWidget(
            transitionDuration: transitionDuration,
            isDownloaded: _isDownloaded,
            isDownloading: _isDownloading,
            isFetching: _isFetching,
            isNotDownloaded: _isNotDownloaded,
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: transitionDuration,
              opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
              curve: Curves.ease,
              child: ProgressIndicatorWidget(
                downloadProgress: downloadProgress,
                isDownloading: _isDownloading,
                isFetching: _isFetching,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget(
      {super.key,
      required this.isDownloading,
      required this.isDownloaded,
      required this.isFetching,
      required this.transitionDuration,
      required this.isNotDownloaded});

  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final bool isNotDownloaded;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    var shape = const ShapeDecoration(
      shape: StadiumBorder(),
      color: CupertinoColors.lightBackgroundGray,
    );

    double wideIconSize = (MediaQuery.of(context).size.width -
            (UIConst.paddingScreen.right + UIConst.paddingScreen.left)) /
        4;

    if (isDownloading || isFetching) {
      shape = ShapeDecoration(
        shape: const CircleBorder(),
        color: Colors.white.withOpacity(0),
      );
    }

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: isNotDownloaded ? wideIconSize : 33,
      height: 33,
      decoration: shape,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedOpacity(
          duration: transitionDuration,
          opacity: isDownloading || isFetching ? 0.0 : 1.0,
          curve: Curves.ease,
          child: isDownloaded
              ? const  Icon(
                  Icons.download_done,
                  color: Colors.green,
                  size: 20,
                )
              : Text(
                  'GET',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.activeBlue,
                      ),
                ),
        ),
      ),
    );
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.downloadProgress,
    required this.isDownloading,
    required this.isFetching,
  });

  final double downloadProgress;
  final bool isDownloading;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: downloadProgress),
        duration: const Duration(milliseconds: 200),
        builder: (context, progress, child) {
          return SizedBox(
            width: 33,
            height: 33,
            child: CircularProgressIndicator(
              backgroundColor: isDownloading
                  ? CupertinoColors.lightBackgroundGray
                  : Colors.white.withOpacity(0),
              valueColor: AlwaysStoppedAnimation(isFetching
                  ? CupertinoColors.lightBackgroundGray
                  : CupertinoColors.activeBlue
              ),
              strokeWidth: 2,
              value: isFetching ? null : progress,
            ),
          );
        },
      ),
    );
  }
}
