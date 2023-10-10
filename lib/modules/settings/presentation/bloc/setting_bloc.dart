import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:video_to_audio/modules/settings/domain/use_case/choose_directory.dart' as Set;
import 'package:video_to_audio/modules/settings/domain/use_case/get_directory.dart' as Get;
import 'package:video_to_audio/modules/settings/domain/use_case/request_permission.dart' as Permission;

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final Permission.RequestPermission _requestPermission;
  final Set.ChooseDirectory _chooseDirectory;
  final Get.GetDirectory _getDirectory;

  SettingBloc(this._requestPermission, this._chooseDirectory, this._getDirectory)
      : super(SettingInitial()) {
    on<OnRequestPermission>(_onRequestPermission);
    on<OnChooseDirectory>(_onChooseDirectory);
    on<OnGetDirectory>(_onGetDirectory);
  }

  Future<void> _onRequestPermission(OnRequestPermission event, Emitter<SettingState> emit) async{
    emit(LoadingStart());
    final result = await _requestPermission(Permission.Params());
    result.fold((failure) {
      emit(SettingError(failure.message.toString()));
    }, (data) {
      emit(HasPermission());
    });
    emit(LoadingStop());
  }

  Future<void> _onChooseDirectory(OnChooseDirectory event, Emitter<SettingState> emit) async{
    emit(LoadingStart());

    final result = await _chooseDirectory(Set.Params());
    result.fold((failure) {
      emit(DirectoryError(failure.message.toString()));
    }, (data) {
      emit(HasDirectoryData(data));
    });
    emit(LoadingStop());
  }

  Future<void> _onGetDirectory(OnGetDirectory event, Emitter<SettingState> emit) async{
    emit(LoadingStart());
    final result = await _getDirectory(Get.Params());
    result.fold((failure) {
      emit(DirectoryError(failure.message.toString()));
    }, (data) {
      emit(HasDirectoryData(data));
    });
    emit(LoadingStop());
  }
}
