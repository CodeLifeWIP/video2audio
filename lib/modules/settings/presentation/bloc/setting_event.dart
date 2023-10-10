part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class OnReadPermission extends SettingEvent {}
class OnRequestPermission extends SettingEvent {}

class OnChooseDirectory extends SettingEvent {}
class OnGetDirectory extends SettingEvent {}



