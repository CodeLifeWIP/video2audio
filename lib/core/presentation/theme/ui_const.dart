import 'package:flutter/material.dart';

class UIConst {

  // AppBar
  static String appName = "Video to Audio Downloader";
  static Size appBarSize = const Size.fromHeight(56.0);

  // Paddings
  static double paddingSize = 16.0;
  static EdgeInsets paddingScreen = EdgeInsets.all(paddingSize);
  static EdgeInsets paddingBottomSheet = EdgeInsets.only(left: paddingSize, right: paddingSize, bottom: paddingSize);

  // Borders
  static BorderRadius borderRadiusWidget = BorderRadius.circular(15.0);
  static Radius radiusWidget = const Radius.circular(15.0);

  // Colors
  static Color primary = Colors.deepPurple.shade900;
  static Color secondary = Colors.deepPurple.shade400;
  static Color drawerBackground = Colors.deepPurple.shade700;
  static Gradient colorGradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primary,
      secondary,
    ],
  );
  static Color textLight = Colors.white;
  static Color textDark = Colors.black;
  static Color textMid = Colors.grey;

  static Color colorBottomSheetBackground = Colors.white.withOpacity(0.3);
  static Color colorLoadingIndicatorBackground = Colors.transparent;
}
