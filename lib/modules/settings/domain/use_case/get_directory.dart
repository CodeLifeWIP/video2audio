import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:video_to_audio/core/domain/use_case/use_case.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/settings/domain/repository/setting_repository.dart';

class GetDirectory implements UseCase<String, Params>{
  final SettingRepository repository;

  GetDirectory(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params){
    return repository.getDirectory();
  }

}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}