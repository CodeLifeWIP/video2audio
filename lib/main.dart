import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_to_audio/modules/home/presentation/bloc/downloader_bloc.dart';
import 'package:video_to_audio/modules/home/presentation/screens/home.dart';
import 'package:video_to_audio/modules/settings/presentation/bloc/setting_bloc.dart';
import 'core/injection.dart' as di;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
