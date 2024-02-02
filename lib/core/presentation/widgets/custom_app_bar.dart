import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/theme/ui_const.dart';
import 'package:video_to_audio/modules/settings/presentation/screens/setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum LeadingIconType { main, sub }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LeadingIconType leadingIcon;

  const CustomAppBar({super.key, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.app_title,
        style: TextStyle(
          color: UIConst.textLight,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: (leadingIcon == LeadingIconType.main)
          ? Icon(
              Icons.multitrack_audio_sharp,
              color: UIConst.textLight,
            )
          : IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: UIConst.textLight,
              ),
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
                icon: Icon(
                  Icons.settings,
                  color: UIConst.textLight,
                ),
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
