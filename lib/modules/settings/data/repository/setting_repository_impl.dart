import 'package:dartz/dartz.dart';
import 'package:video_to_audio/core/error/exception.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/settings/data/data/setting_data_source.dart';
import 'package:video_to_audio/modules/settings/domain/repository/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingDataSource deviceDataSource;

  SettingRepositoryImpl(
      {required this.deviceDataSource});

  @override
  Future<Either<Failure, bool>> readPermissions() async{
    try{
      final result = await deviceDataSource.hasPermissions();
      return Right(result);
    }catch (e) {
      return Left(DeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermissions() async{
    try{
      final hasPermission = await deviceDataSource.hasPermissions();
      if(!hasPermission){
        final result = await deviceDataSource.requestPermissions();
        return Right(result);
      }
      return const Right(true);
    }catch (e) {
      return Left(DeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setDirectory() async{
    try{
      final chosenDirectory = await deviceDataSource.chooseDirectory();
      await deviceDataSource.saveDirectory(chosenDirectory);

      return Right(chosenDirectory);
    }catch (e) {
      return Left(DeviceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getDirectory() async{
    try{
      final result = await deviceDataSource.getDirectory();
      return Right(result);
    }catch (e) {
      return Left(DeviceFailure(e.toString()));
    }
  }
}
