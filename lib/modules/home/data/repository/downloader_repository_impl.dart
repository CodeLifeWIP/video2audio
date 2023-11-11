import 'package:dartz/dartz.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/error/failure.dart';
import 'package:video_to_audio/modules/home/data/data/device_data_source.dart';
import 'package:video_to_audio/modules/home/data/data/downloader_data_source.dart';
import 'package:video_to_audio/modules/home/domain/repository/downloader_repository.dart';

class DownloaderRepositoryImpl implements DownloaderRepository {
  final DownloaderDataSource remoteDataSource;
  final DeviceDataSource deviceDataSource;

  DownloaderRepositoryImpl(
      {required this.remoteDataSource, required this.deviceDataSource});

  @override
  Future<Either<Failure, VideoData>> getUrlData(String url) async {
    try {
      final result = await remoteDataSource.getUrlData(url);
      return Right(result.toEntity());
    } catch (e) {
      return Left(DownloadFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> downloadAudioFile(VideoData videoData, String saveTo, String filename) async {
    try {
      final result = await remoteDataSource.downloadAudioFile(videoData, saveTo, filename);
      return Right(result);
    } catch (e) {
      return Left(DownloadFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Stream<String>> downloadAudioFileStream(VideoData videoData, String saveTo, String filename) {
    try {
      final result = remoteDataSource.downloadAudioFileStream(videoData, saveTo, filename);
      return Right(result);
    } catch (e) {
      return Left(DownloadFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> readPermissions() async{
    try{
      final result = await deviceDataSource.hasPermissions();
      return Right(result);
    }catch (e) {
      return Left(DownloadFailure(e.toString()));
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
      return Left(DownloadFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getDirectory() async{
    try{
      final result = await deviceDataSource.getDirectory();
      return Right(result);
    }catch (e) {
      return Left(DownloadFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> closeConnections() async{
    try{
      final result = await remoteDataSource.closeConnection();
      return Right(result);
    }catch (e) {
      return Left(DownloadFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openDownloadedFile(String directory, String filename) async{
    try{
      await deviceDataSource.openDownloadedFile(directory, filename);
      return const Right(null);
    }catch (e) {
      return Left(DownloadFailure(e.toString()));
    }
  }


}
