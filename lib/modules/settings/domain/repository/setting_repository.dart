import 'package:dartz/dartz.dart';
import 'package:video_to_audio/core/error/failure.dart';

abstract class SettingRepository {
  Future<Either<Failure, bool>> readPermissions();
  Future<Either<Failure, bool>> requestPermissions();
  Future<Either<Failure, String>> setDirectory();
  Future<Either<Failure, String>> getDirectory();
}