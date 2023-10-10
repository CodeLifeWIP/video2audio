import 'package:equatable/equatable.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';

class ThumbnailModel extends Equatable {
  final String? videoId;
  final String? lowRes;
  final String? mediumRes;
  final String? highRes;
  final String? maxRes;
  final String? standardRes;

  const ThumbnailModel(
      {this.videoId,
      this.lowRes,
      this.mediumRes,
      this.highRes,
      this.maxRes,
      this.standardRes});

  factory ThumbnailModel.fromYoutubeExplodeThumbnailSet(ThumbnailSet set) => ThumbnailModel(
    videoId: set.videoId,
    lowRes: set.lowResUrl,
    mediumRes: set.mediumResUrl,
    highRes: set.highResUrl,
    maxRes: set.maxResUrl,
    standardRes: set.standardResUrl
  );

  Thumbnails toEntity() => Thumbnails(
    videoId: videoId,
    lowRes: lowRes,
    mediumRes: mediumRes,
    highRes: highRes,
    maxRes: maxRes,
    standardRes: standardRes
  );

  @override
  List<Object?> get props => [
    videoId,
    lowRes,
    mediumRes,
    highRes,
    maxRes,
    standardRes
  ];
}