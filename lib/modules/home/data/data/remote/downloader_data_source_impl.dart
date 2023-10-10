import 'dart:developer';
import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/core/error/exception.dart';
import 'package:video_to_audio/modules/home/data/data/downloader_data_source.dart';
import 'package:video_to_audio/modules/home/data/model/AutioStreamDataModel.dart';
import 'package:video_to_audio/modules/home/data/model/VideoDataModel.dart';

class DownloaderDataSourceImpl implements DownloaderDataSource {
  final YoutubeExplode client;

  DownloaderDataSourceImpl({required this.client});

  @override
  Future<VideoDataModel> getUrlData(String url) async {
    try {
      var video = await client.videos.get(url);
      var streamManifest =
          await client.videos.streamsClient.getManifest(video.id);

      var videoDataModel = VideoDataModel.fromYoutubeExplodeVideo(video);
      videoDataModel.audioStreamData =
          AudioStreamData.fromYoutubeExplodeStreamManifest(streamManifest);

      return videoDataModel;
    } catch (e) {
      throw const DownloadException("Cannot get URL.");
    }
  }

  @override
  Future<String> downloadAudioFile(
      VideoData videoData, String saveTo, String filename) async {

    try {
      final video = await client.videos.get(videoData.url);
      final manifest = await client.videos.streamsClient.getManifest(video.id);
      final streamInfo = manifest.audioOnly.withHighestBitrate();

      if (streamInfo != null) {
        var file = File("$saveTo/$filename.${streamInfo.container.name}");
        var fileStream = file.openWrite();

        var stream = client.videos.streamsClient.get(streamInfo);
        await stream.pipe(fileStream);

        await fileStream.flush();
        await fileStream.close();

        return "Downloaded to ${saveTo}";
      }
      throw const DownloadException("");

    } catch (e) {
      throw const DownloadException("");
    }
  }

  @override
  Future<void> closeConnection() async {
    try{
      client.close();
    }catch (e){
      throw const DownloadException("Close connection exception");
    }
  }
}
