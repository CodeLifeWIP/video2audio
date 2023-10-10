import 'package:equatable/equatable.dart';

class VideoData extends Equatable {
  final String? videoId;
  final String? channelId;
  final String? url;
  final String? title;
  final String? description;
  final String? duration;
  final Thumbnails? thumbnails;
  final String? author;
  final AudioManifest? audioManifest;

  const VideoData(
      {this.videoId,
      this.channelId,
      this.url,
      this.title,
      this.description,
      this.duration,
      this.thumbnails,
      this.author,
      this.audioManifest});

  @override
  List<Object?> get props => [
    videoId,
    channelId,
    url,
    title,
    description,
    duration,
    thumbnails,
    author,
    audioManifest
  ];
}

class Thumbnails extends Equatable {
  final String? videoId;
  final String? lowRes;
  final String? mediumRes;
  final String? highRes;
  final String? maxRes;
  final String? standardRes;

  const Thumbnails(
      {this.videoId,
        this.lowRes,
        this.mediumRes,
        this.highRes,
        this.maxRes,
        this.standardRes});

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

class AudioManifest extends Equatable {
  final String? url;
  final Sizes? sizes;
  final String? audioCodec;
  final String? qualityLabel;

  const AudioManifest({this.url, this.sizes, this.audioCodec, this.qualityLabel});

  @override
  List<Object?> get props => [url, sizes, audioCodec, qualityLabel];
}

class Sizes extends Equatable {
  final double? inGigaBytes;
  final double? inMegaBytes;
  final double? inKiloByte;
  final int? inBytes;

  const Sizes({this.inGigaBytes, this.inMegaBytes, this.inKiloByte, this.inBytes});

  @override
  List<Object?> get props => [inGigaBytes, inMegaBytes, inKiloByte, inBytes];

}
