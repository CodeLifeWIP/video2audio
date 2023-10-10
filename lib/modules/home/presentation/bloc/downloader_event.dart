part of 'downloader_bloc.dart';

@immutable
abstract class DownloaderEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class OnGetUrlData extends DownloaderEvent{
  final String url;
  OnGetUrlData(this.url);

  @override
  List<Object?> get props => [url];
}

class OnDownloadAudio extends DownloaderEvent{
  final VideoData videoData;
  final String saveTo;
  final String filename;
  OnDownloadAudio(this.videoData, this.saveTo, this.filename);

  @override
  List<Object?> get props => [videoData, saveTo, filename];
}

class OnReadPermission extends DownloaderEvent {}
class OnRequestPermission extends DownloaderEvent {}

class OnGetDirectory extends DownloaderEvent {}

class OnCloseConnections extends DownloaderEvent {}



