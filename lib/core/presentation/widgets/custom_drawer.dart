import 'package:flutter/material.dart';
import 'package:video_to_audio/modules/player/presentation/screen/player.dart';
import 'package:video_to_audio/modules/settings/presentation/screens/setting.dart';

import '../theme/ui_const.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: UIConst.drawerBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 75.0, bottom: 50.0),
            child: ListTile(
              leading: Icon(
                Icons.multitrack_audio,
                color: UIConst.textLight,
                size: 50.0,
              ),
              onTap: () {
                // Update the state of the app

                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            title: Text(
              'MENU',
              style: TextStyle(
                  color: UIConst.textLight, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Update the state of the app

              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                'Home',
                style: TextStyle(color: UIConst.textLight),
              ),
            ),
            onTap: () {
              // Update the state of the app

              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                'Player',
                style: TextStyle(color: UIConst.textLight),
              ),
            ),
            onTap: () {
              // Then close the drawer
              Navigator.pop(context);
              // Update the state of the app
              Player.navigateTo(context);
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                'Settings',
                style: TextStyle(color: UIConst.textLight),
              ),
            ),
            onTap: () {
              // Then close the drawer
              Navigator.pop(context);

              // Update the state of the app
              Setting.navigateTo(context);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              'RECENT',
              style: TextStyle(
                  color: UIConst.textLight, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Update the state of the app

              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
