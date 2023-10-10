import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_to_audio/core/domain/use_case/use_case.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/settings/domain/repository/setting_repository.dart';

class ChooseDirectory implements UseCase<String, Params>{
  final SettingRepository repository;

  ChooseDirectory(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) {
    return repository.setDirectory();
  }

}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}