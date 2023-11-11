import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/use_case/use_case.dart';
import '../../../../core/error/failure.dart';
import '../repository/downloader_repository.dart';

class OpenDownloadedFile implements UseCase<void, Params> {
  final DownloaderRepository repository;

  OpenDownloadedFile(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.openDownloadedFile(params.directory, params.filename);
  }
}

class Params extends Equatable {
  final String directory;
  final String filename;

  const Params(this.directory, this.filename);

  @override
  List<Object?> get props => [directory, filename];
}