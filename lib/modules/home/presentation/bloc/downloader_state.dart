part of 'downloader_bloc.dart';

@immutable
abstract class DownloaderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloaderInitial extends DownloaderState {}
class DownloaderError extends DownloaderState{
  final String error;

  DownloaderError(this.error);

  @override
  List<Object?> get props => [error];
}

class LoadingStart extends DownloaderState{}
class LoadingStop extends DownloaderState{}
class ConnectionsClosed extends DownloaderState{}

class NoVideoData extends DownloaderState {}
class HasVideoData extends DownloaderState {
  final VideoData videoData;
  HasVideoData(this.videoData);

  @override
  List<Object?> get props => [videoData];
}

class AudioIsDownloading extends DownloaderState {}
class AudioDownloadingError extends DownloaderState {
  final String error;

  AudioDownloadingError(this.error);

  @override
  List<Object?> get props => [error];
}
class AudioDownloadingSuccess extends DownloaderState {
  final String message;
  AudioDownloadingSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AudioDownloadingHasProgress extends DownloaderState {
  final String message;
  AudioDownloadingHasProgress(this.message);

  @override
  List<Object?> get props => [message];
}

class HasNoPermission extends DownloaderState {}
class HasPermission extends DownloaderState {}

class DirectoryError extends DownloaderState {
  final String error;

  DirectoryError(this.error);

  @override
  List<Object?> get props => [error];
}
class HasDirectoryData extends DownloaderState {
  final String directory;

  HasDirectoryData(this.directory);

  @override
  List<Object?> get props => [directory];
}


