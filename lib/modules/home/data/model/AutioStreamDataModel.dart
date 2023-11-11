import 'package:equatable/equatable.dart';
import 'package:sanitize_filename/sanitize_filename.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';

class AudioStreamData extends Equatable {
  final String? url;
  final SizeSet? sizeSet;
  final String? audioCodec;
  final String? qualityLabel;

  final String? filename;

  const AudioStreamData({
    this.url,
    this.sizeSet,
    this.audioCodec,
    this.qualityLabel,
    this.filename,
  });

  factory AudioStreamData.fromYoutubeExplodeStreamManifest(
          StreamManifest streamManifest, String title) {

    final audio = streamManifest.audioOnly.first;
    final fileName = sanitizeFilename('${title}.${audio.container.name}', replacement: '_');

    return AudioStreamData(
        url: streamManifest.audioOnly.withHighestBitrate().url.data?.uri.path,
        sizeSet: SizeSet.fromYoutubeExplodeSize(
            streamManifest.audioOnly.withHighestBitrate().size),
        audioCodec: streamManifest.audioOnly.withHighestBitrate().audioCodec,
        qualityLabel:
        streamManifest.audioOnly.withHighestBitrate().qualityLabel,
        filename: fileName
    );
  }


  AudioManifest toEntity() => AudioManifest(
    url: url,
    audioCodec: audioCodec,
    qualityLabel: qualityLabel,
    sizes: sizeSet?.toEntity(),
    filename: filename,
  );


  @override
  List<Object?> get props => [url, sizeSet, audioCodec, qualityLabel, filename];
}

class SizeSet extends Equatable {
  final double? inGigaBytes;
  final double? inMegaBytes;
  final double? inKiloByte;
  final int? inBytes;

  const SizeSet(
      {this.inGigaBytes, this.inMegaBytes, this.inKiloByte, this.inBytes});

  factory SizeSet.fromYoutubeExplodeSize(FileSize size) => SizeSet(
      inGigaBytes: size.totalGigaBytes,
      inMegaBytes: size.totalMegaBytes,
      inKiloByte: size.totalKiloBytes,
      inBytes: size.totalBytes);

  Sizes toEntity() => Sizes(
      inBytes: inBytes,
      inKiloByte: inKiloByte,
      inMegaBytes: inMegaBytes,
      inGigaBytes: inGigaBytes);

  @override
  List<Object?> get props => [inGigaBytes, inMegaBytes, inKiloByte, inBytes];
}
