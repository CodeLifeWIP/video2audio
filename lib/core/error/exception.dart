import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  final String message;
  const Exception(this.message);

  @override
  List<Object> get props => [message];
}

class DeviceException extends Exception {
  const DeviceException(String message) : super(message);
}

class DownloadException extends Exception {
  const DownloadException(String message) : super(message);
}