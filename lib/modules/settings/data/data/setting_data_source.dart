abstract class SettingDataSource {
  Future<bool> hasPermissions();
  Future<bool> requestPermissions();
  Future<String> chooseDirectory();
  Future<bool> saveDirectory(String directoryPath);
  Future<String> getDirectory();
  Future<String> getDefaultDirectory();
}