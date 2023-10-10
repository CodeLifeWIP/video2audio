abstract class DeviceDataSource {
  Future<bool> hasPermissions();
  Future<bool> requestPermissions();
  Future<String> getDirectory();
  Future<String> getDefaultDirectory();
}