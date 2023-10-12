import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:video_to_audio/core/domain/entity/Video.dart';
import 'package:video_to_audio/modules/home/domain/use_case/download_audio_file_with_progress.dart' as WithProgress;
import 'package:video_to_audio/modules/home/domain/use_case/get_directory.dart'
    as Get;
import 'package:video_to_audio/modules/home/domain/use_case/request_permission.dart'
    as Device;
import 'package:video_to_audio/modules/home/domain/use_case/download_audio_file.dart'
    as Download;
import 'package:video_to_audio/modules/home/domain/use_case/close_connections.dart'
    as Close;
import 'package:video_to_audio/modules/home/domain/use_case/get_url_data.dart';

part 'downloader_event.dart';

part 'downloader_state.dart';

class DownloaderBloc extends Bloc<DownloaderEvent, DownloaderState> {
  final GetUrlData _getUrlData;
  final Download.DownloadAudioFile _downloadAudioFile;
  final Device.RequestPermission _requestPermission;
  final Get.GetDirectory _getDirectory;
  final Close.CloseConnections _closeConnections;
  final WithProgress.DownloadAudioFileWithProgress _downloadAudioFileWithProgress;

  DownloaderBloc(this._getUrlData, this._downloadAudioFile,
      this._requestPermission, this._getDirectory, this._closeConnections, this._downloadAudioFileWithProgress)
      : super(DownloaderInitial()) {
    on<OnGetUrlData>(_onGetUrlData);
    on<OnDownloadAudio>(_onDownloadAudio);
    on<OnDownloadAudioWithProgress>(_onDownloadAudioWithProgress);
    on<OnRequestPermission>(_onRequestPermission);
    on<OnGetDirectory>(_onGetDirectory);
    on<OnCloseConnections>(_onCloseConnections);
  }

  Future<void> _onGetUrlData(
      OnGetUrlData event, Emitter<DownloaderState> emit) async {
    emit(LoadingStart());
    final result = await _getUrlData(Params(event.url));
    result.fold((failure) {
      emit(NoVideoData());
    }, (data) {
      emit(HasVideoData(data));
    });
    emit(LoadingStop());
  }

  Future<void> _onDownloadAudio(
      OnDownloadAudio event, Emitter<DownloaderState> emit) async {
    emit(AudioIsDownloading());
    final result = await _downloadAudioFile(
        Download.Params(event.videoData, event.saveTo, event.filename));
    result.fold((failure) {
      emit(AudioDownloadingError(failure.message.toString()));
    }, (data) {
      emit(AudioDownloadingSuccess(data));
    });
  }


  Future<void> _onDownloadAudioWithProgress(
      OnDownloadAudioWithProgress event, Emitter<DownloaderState> emit) async {
    emit(AudioIsDownloading());
    final result = _downloadAudioFileWithProgress(
        WithProgress.Params(event.videoData, event.saveTo, event.filename));

    await result.fold((failure) {
      emit(AudioDownloadingError(failure.message.toString()));
    }, (data) async{

      await emit.forEach(data, onData: (String data) {
        return AudioDownloadingHasProgress(data);
      });

      emit(AudioDownloadingSuccess(""));

    });
  }

  Future<void> _onRequestPermission(
      OnRequestPermission event, Emitter<DownloaderState> emit) async {
    final result = await _requestPermission(Device.Params());
    result.fold((failure) {
      emit(DirectoryError(failure.message.toString()));
    }, (data) {
      emit(HasPermission());
    });
  }

  Future<void> _onGetDirectory(
      OnGetDirectory event, Emitter<DownloaderState> emit) async {
    emit(LoadingStart());
    final result = await _getDirectory(Get.Params());
    result.fold((failure) {
      emit(DirectoryError(failure.message.toString()));
    }, (data) {
      emit(HasDirectoryData(data));
    });
    emit(LoadingStop());
  }

  Future<void> _onCloseConnections(
      OnCloseConnections event, Emitter<DownloaderState> emit) async {
    emit(LoadingStart());
    final result = await _closeConnections(Close.Params());
    result.fold((failure) {
      emit(DownloaderError(failure.message.toString()));
    }, (data) {
      emit(ConnectionsClosed());
    });
    emit(LoadingStop());
  }
}
