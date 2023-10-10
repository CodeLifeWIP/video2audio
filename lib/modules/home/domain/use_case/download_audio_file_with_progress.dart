import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/domain/use_case/use_case.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/home/domain/repository/downloader_repository.dart';

class DownloadAudioFileWithProgress implements UseCaseStream<String, Params> {
  final DownloaderRepository repository;

  DownloadAudioFileWithProgress(this.repository);

  @override
  Either<Failure, Stream<String>> call(Params params) {
    return repository.downloadAudioFileStream(params.videoData, params.saveTo, params.filename);
  }
}

class Params extends Equatable {
  final VideoData videoData;
  final String saveTo;
  final String filename;

  const Params(this.videoData, this.saveTo, this.filename);

  @override
  List<Object?> get props => [videoData, saveTo, filename];

}