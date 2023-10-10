import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/modules/home/data/model/AutioStreamDataModel.dart';
import 'package:video_to_audio/modules/home/data/model/ThumbnailModel.dart';

class VideoDataModel extends Equatable{
  final String? videoId;
  final String? channelId;
  final String? url;
  final String? title;
  final String? description;
  final String? duration;
  final ThumbnailModel? thumbnailModel;
  final String? author;
  AudioStreamData? audioStreamData;

   VideoDataModel(
      {this.videoId,
      this.channelId,
      this.url,
      this.title,
      this.description,
      this.duration,
      this.thumbnailModel,
      this.author,
      this.audioStreamData});

  factory VideoDataModel.fromYoutubeExplodeVideo(Video video) => VideoDataModel(
    videoId: video.id.value,
    channelId: video.channelId.value,
    url: video.url,
    title: video.title,
    description: video.description,
    duration: video.duration.toString(),
    author: video.author,
    thumbnailModel: ThumbnailModel.fromYoutubeExplodeThumbnailSet(video.thumbnails)
  );

  VideoData toEntity() => VideoData(
    videoId: videoId,
    channelId: channelId,
    url: url,
    title: title,
    description: description,
    duration: duration,
    author: author,
    thumbnails: thumbnailModel?.toEntity(),
    audioManifest: audioStreamData?.toEntity()
  );

  @override
  List<Object?> get props => [
    videoId,
    channelId,
    url,
    title,
    description,
    duration,
    thumbnailModel,
    author
  ];

}