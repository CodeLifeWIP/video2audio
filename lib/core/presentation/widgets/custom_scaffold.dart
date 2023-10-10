import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/core/presentation/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final LeadingIconType leadingIcon;

  const CustomScaffold({Key? key, this.body, required this.leadingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: UIConst.colorGradientBackground,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          leadingIcon: leadingIcon,
        ),
        body: SafeArea(child: body!),
      ),
    );
  }

}
