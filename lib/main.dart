import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_to_audio/modules/home/presentation/bloc/downloader_bloc.dart';
import 'package:video_to_audio/modules/home/presentation/screens/home.dart';
import 'package:video_to_audio/modules/settings/presentation/bloc/setting_bloc.dart';
import 'core/injection.dart' as di;

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


  di.init();
  await di.locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.locator.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.locator<DownloaderBloc>()),
            BlocProvider(create: (_) => di.locator<SettingBloc>()),
          ],
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const Home(),
            ),
          ),
        );
      },
    );
  }
}
