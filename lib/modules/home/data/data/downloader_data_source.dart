import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/modules/home/data/model/VideoDataModel.dart';

abstract class DownloaderDataSource {
  Future<VideoDataModel> getUrlData(String url);
  Future<String> downloadAudioFile(VideoData videoData, String saveTo, String filename);
  Stream<String> downloadAudioFileStream(VideoData videoData, String saveTo, String filename);
  Future<void> closeConnection();
}