

import 'package:flutter/material.dart';
import 'package:studyapp_flutter/configs/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFF8ED6FF);
const Color primaryColorLight = Color(0xFFFFC1C8);
const Color primaryColorLight2 = Color(0xFFf85187);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        primaryColor: primaryColorLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: getIconTheme(),
        cardColor: cardColor,
        textTheme: getTextThemes().apply(
            bodyColor: mainTextColorLight, displayColor: mainTextColorLight));
  }
}
