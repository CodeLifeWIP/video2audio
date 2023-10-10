import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_to_audio/core/domain/use_case/use_case.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/home/domain/repository/downloader_repository.dart';

class RequestPermission implements UseCase<bool, Params> {
  final DownloaderRepository repository;

  RequestPermission(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.requestPermissions();
  }
}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}