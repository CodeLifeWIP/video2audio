part of 'setting_bloc.dart';

@immutable
abstract class SettingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingInitial extends SettingState {}
class SettingError extends SettingState{
  final String error;

  SettingError(this.error);

  @override
  List<Object?> get props => [error];
}

class LoadingStart extends SettingState{}
class LoadingStop extends SettingState{}

class HasNoPermission extends SettingState {}
class HasPermission extends SettingState {}

class DirectoryError extends SettingState {
  final String error;

  DirectoryError(this.error);

  @override
  List<Object?> get props => [error];
}
class HasDirectoryData extends SettingState {
  final String directory;

  HasDirectoryData(this.directory);

  @override
  List<Object?> get props => [directory];
}


