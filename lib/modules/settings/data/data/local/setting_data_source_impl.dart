import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_to_audio/core/error/exception.dart';
import 'package:video_to_audio/modules/settings/data/data/setting_data_source.dart';

class SettingDataSourceImpl implements SettingDataSource{

  final SharedPreferences sharedPreferences;

  SettingDataSourceImpl({required  this.sharedPreferences});

  @override
  Future<bool> hasPermissions() async{
    try{
      return await Permission.mediaLibrary.isGranted;
    }catch (e) {
      throw const DeviceException("Has permission excetption");
    }
  }

  @override
  Future<bool> requestPermissions() async{
    try{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.mediaLibrary,
      ].request();

      return true;
    }catch (e) {
      throw const DeviceException("Request permission exception");
    }
  }

  @override
  Future<String> chooseDirectory() async{
    try{
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        return selectedDirectory;
      }

      return await getDefaultDirectory();
    }catch(e){
      throw const DeviceException("Choose directory exception");
    }
  }

  @override
  Future<bool> saveDirectory(String directoryPath) async{
    try{
      final result = await sharedPreferences.setString('directory', directoryPath);
      return result;
    }catch(e){
      throw const DeviceException("Save directory exception");
    }
  }

  @override
  Future<String> getDirectory() async{
    try{
      final result =  sharedPreferences.getString('directory');
      return result ?? await getDefaultDirectory();
    }catch(e){
      throw  const DeviceException("Get directory exception");
    }
  }

  @override
  Future<String> getDefaultDirectory() async{
    try{
      var dirType = DownloadDirectoryTypes.dcim;
      Directory? downloadsDirectory = await DownloadsPath.downloadsDirectory(dirType: dirType);
      return downloadsDirectory!.path;
    }catch(e){
    throw const DeviceException("Default directory exception");
    }
  }

}