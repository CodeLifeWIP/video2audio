import 'dart:developer';
import 'dart:io';
import 'package:sanitize_filename/sanitize_filename.dart';
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
  Stream<String> downloadAudioFileStream(VideoData videoData, String saveTo, String filename) async*{
    try {
      // Get video metadata.
      final video = await client.videos.get(videoData.url);

      // Get the video manifest.
      final manifest = await client.videos.streamsClient.getManifest(video.id);
      final streams = manifest.audioOnly;

      // Get the audio track with the highest bitrate.
      final audio = streams.first;
      final audioStream = client.videos.streamsClient.get(audio);

      // Compose the file name removing the not allowed characters in windows.
      final fileName = sanitizeFilename('${video.title}.${audio.container.name}', replacement: '_');

      var file = File("$saveTo/$fileName");

      // Delete the file if exists.
      if (file.existsSync()) {
        file.deleteSync();
      }

      // Open the file in writeAppend.
      final output = file.openWrite(mode: FileMode.writeOnlyAppend);

      // Track the file download status.
      final len = audio.size.totalBytes;
      var count = 0;

      // Create the message and set the cursor position.
      final msg = 'Downloading ${video.title}.${audio.container.name}';
      // stdout.writeln(msg);
      // log(msg);

      // Listen for data received.
      // final progressBar = ProgressBar();
      await for (final data in audioStream) {
        // Keep track of the current downloaded data.
        count += data.length;

        // Write to file.
        output.add(data);

        // Calculate the current progress.
        final progress = ((count / len) * 100).ceil();

        // Update the progressbar.
        yield progress.toString();
      }
      await output.close();
      // return "Downloaded to ${file.path}";
      // throw const DownloadException("");

    } catch (e) {
      throw DownloadException("${e.toString()}");
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
