import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:video_to_audio/modules/home/data/data/device_data_source.dart';
import 'package:video_to_audio/modules/home/data/data/downloader_data_source.dart';
import 'package:video_to_audio/modules/home/data/data/local/device_data_source_impl.dart';
import 'package:video_to_audio/modules/home/data/data/remote/downloader_data_source_impl.dart';
import 'package:video_to_audio/modules/home/data/repository/downloader_repository_impl.dart';
import 'package:video_to_audio/modules/home/domain/repository/downloader_repository.dart';
import 'package:video_to_audio/modules/home/domain/use_case/download_audio_file.dart';
import 'package:video_to_audio/modules/home/domain/use_case/get_directory.dart';
import 'package:video_to_audio/modules/home/domain/use_case/get_url_data.dart';
import 'package:video_to_audio/modules/home/domain/use_case/read_permissions.dart';
import 'package:video_to_audio/modules/home/domain/use_case/request_permission.dart';
import 'package:video_to_audio/modules/home/presentation/bloc/downloader_bloc.dart';
import 'package:video_to_audio/modules/settings/data/data/local/setting_data_source_impl.dart';
import 'package:video_to_audio/modules/settings/data/data/setting_data_source.dart';
import 'package:video_to_audio/modules/settings/data/repository/setting_repository_impl.dart';
import 'package:video_to_audio/modules/settings/domain/repository/setting_repository.dart';
import 'package:video_to_audio/modules/settings/domain/use_case/choose_directory.dart' as  SettingSetDir;
import 'package:video_to_audio/modules/settings/domain/use_case/get_directory.dart' as SettingGetDir;
import 'package:video_to_audio/modules/settings/domain/use_case/read_permissions.dart' as SettingReadPer;
import 'package:video_to_audio/modules/settings/domain/use_case/request_permission.dart' as SettingRequestPer;
import 'package:video_to_audio/modules/home/domain/use_case/close_connections.dart';
import 'package:video_to_audio/modules/settings/presentation/bloc/setting_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // External / 3rd Party
  locator.registerLazySingleton(() => YoutubeExplode());

  // Databases
  locator.registerSingletonAsync<SharedPreferences>(() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp;
  });

  // Data Source
  locator.registerLazySingleton<DownloaderDataSource>(
    () => DownloaderDataSourceImpl(client: locator()),
  );

  locator.registerSingletonWithDependencies<DeviceDataSource>(
      () => DeviceDataSourceImpl(sharedPreferences: locator()),
      dependsOn: [SharedPreferences]);

  locator.registerSingletonWithDependencies<SettingDataSource>(
          () => SettingDataSourceImpl(sharedPreferences: locator()),
      dependsOn: [SharedPreferences]);

  // Repository
  locator.registerSingletonWithDependencies<DownloaderRepository>(
      () => DownloaderRepositoryImpl(
          remoteDataSource: locator(), deviceDataSource: locator()),
      dependsOn: [DeviceDataSource]);

  locator.registerSingletonWithDependencies<SettingRepository>(
          () => SettingRepositoryImpl(deviceDataSource: locator()),
      dependsOn: [SettingDataSource]);


  // Use_Case
  locator.registerSingletonWithDependencies(() => GetUrlData(locator()),
      dependsOn: [DownloaderRepository]);
  locator.registerSingletonWithDependencies(() => DownloadAudioFile(locator()),
      dependsOn: [DownloaderRepository]);
  locator.registerSingletonWithDependencies(() => ReadPermissions(locator()),
      dependsOn: [DownloaderRepository]);
  locator.registerSingletonWithDependencies(() => RequestPermission(locator()),
      dependsOn: [DownloaderRepository]);
  locator.registerSingletonWithDependencies(() => GetDirectory(locator()),
      dependsOn: [DownloaderRepository]);
  locator.registerSingletonWithDependencies(() => CloseConnections(locator()),
      dependsOn: [DownloaderRepository]);

  locator.registerSingletonWithDependencies(() => SettingSetDir.ChooseDirectory(locator()),
      dependsOn: [SettingRepository]);
  locator.registerSingletonWithDependencies(() => SettingGetDir.GetDirectory(locator()),
      dependsOn: [SettingRepository]);
  locator.registerSingletonWithDependencies(() => SettingReadPer.ReadPermissions(locator()),
      dependsOn: [SettingRepository]);
  locator.registerSingletonWithDependencies(() => SettingRequestPer.RequestPermission(locator()),
      dependsOn: [SettingRepository]);


  // Bloc
  locator.registerSingletonWithDependencies(
      () =>
          DownloaderBloc(locator(), locator(), locator(), locator(), locator()),
      dependsOn: [
        GetUrlData,
        DownloadAudioFile,
        ReadPermissions,
        RequestPermission,
        GetDirectory,
        CloseConnections,
      ]);

  locator.registerSingletonWithDependencies(
          () =>
          SettingBloc(locator(), locator(), locator()),
      dependsOn: [
        SettingRequestPer.RequestPermission,
        SettingGetDir.GetDirectory,
        SettingSetDir.ChooseDirectory,
      ]);

}
