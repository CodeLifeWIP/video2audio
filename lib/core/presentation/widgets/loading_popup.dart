import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';

class AlertLoading extends StatelessWidget {
  const AlertLoading({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertLoading(),
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: UIConst.colorLoadingIndicatorBackground,
      shadowColor: UIConst.colorLoadingIndicatorBackground,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: UIConst.secondary,
          ),
        ],
      ),
    );
  }
}
