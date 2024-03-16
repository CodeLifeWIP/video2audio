import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_app_bar.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Widget? body;
  final LeadingIconType leadingIcon;

  CustomScaffold({Key? key, this.body, required this.leadingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: UIConst.colorGradientBackground,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          leadingIcon: leadingIcon,
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        body: SafeArea(child: body!),
        drawer: CustomDrawer(),
      ),
    );
  }
}
