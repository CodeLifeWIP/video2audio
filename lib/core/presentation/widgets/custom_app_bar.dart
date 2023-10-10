import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/modules/settings/presentation/screens/setting.dart';

enum LeadingIconType { main, sub }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LeadingIconType leadingIcon;

  const CustomAppBar({super.key, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        UIConst.appName,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: (leadingIcon == LeadingIconType.main)
          ? const Icon(
              Icons.multitrack_audio_sharp,
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _goBack(context);
              },
            ),
      actions: [
        (leadingIcon == LeadingIconType.main)
            ? IconButton(
                onPressed: () {
                  Setting.navigateTo(context);
                },
                icon: const Icon(Icons.settings),
              )
            : const SizedBox(),
      ],
    );
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Size get preferredSize => UIConst.appBarSize;
}
