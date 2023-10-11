import 'dart:io';

import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_to_audio/core/error/exception.dart';
import 'package:video_to_audio/modules/home/data/data/device_data_source.dart';

class DeviceDataSourceImpl implements DeviceDataSource{

  final SharedPreferences sharedPreferences;

  DeviceDataSourceImpl({required  this.sharedPreferences});

  @override
  Future<bool> hasPermissions() async{
    try{
      return await Permission.mediaLibrary.isGranted;
    }catch (e) {
      throw const DeviceException("Permission exception");
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
      throw const DeviceException("Permission request exception");
    }
  }

  @override
  Future<String> getDirectory() async{
    try{
      final result =  sharedPreferences.getString('directory');
      return result ?? await getDefaultDirectory();
    }catch(e){
      throw const DeviceException("Get directory exception");
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