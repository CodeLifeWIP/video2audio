import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/domain/use_case/use_case.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/home/domain/repository/downloader_repository.dart';

class GetUrlData implements UseCase<VideoData, Params> {
  final DownloaderRepository repository;

  GetUrlData(this.repository);

  @override
  Future<Either<Failure, VideoData>> call(Params params) {
    return repository.getUrlData(params.url);
  }
}

class Params extends Equatable {
  final String url;

  const Params(this.url);

  @override
  List<Object?> get props => [url];
}