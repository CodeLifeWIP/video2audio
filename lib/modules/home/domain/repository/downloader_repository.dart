import 'package:dartz/dartz.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/error/failure.dart';

abstract class DownloaderRepository {
  Future<Either<Failure, VideoData>> getUrlData(String url);
  Future<Either<Failure, String>> downloadAudioFile(VideoData videoData, String saveTo, String filename);
  Either<Failure, Stream<String>> downloadAudioFileStream(VideoData videoData, String saveTo, String filename);
  Future<Either<Failure, bool>> readPermissions();
  Future<Either<Failure, bool>> requestPermissions();
  Future<Either<Failure, String>> getDirectory();
  Future<Either<Failure, void>> openDownloadedFile(String directory, String filename);
  Future<Either<Failure, void>> closeConnections();
}