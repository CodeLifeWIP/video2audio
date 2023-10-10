import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_app_bar.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_scaffold.dart';
import 'package:video_to_audio/modules/home/presentation/widgets/get_url_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leadingIcon: LeadingIconType.main,
      body: SingleChildScrollView(
        child: Padding(
          padding: UIConst.paddingScreen,
          child: const Stack(
            children: [
              GetUrlData(),
            ],
          ),
        ),
      ),
    );
  }
}
