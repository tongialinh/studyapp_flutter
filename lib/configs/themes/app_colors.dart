
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_dark_theme.dart';
import 'package:studyapp_flutter/configs/themes/app_light_theme.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';

const Color onSurfaceTextColor = Colors.black54;
const Color correctAnserColor = Color(0xFF7DE2E8);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notAnsweredColr = Color(0xFF2a3c65);

const mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
    colors: [
      primaryLightColorLight,
      primaryColorLight
    ],
);
const mainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors:[
      primaryDarkColorDark,
      primaryColorDark
    ]
);



LinearGradient mainGradient()=>
    UIParamenters.isDarkMode()?mainGradientDark:mainGradientLight;

Color customScaffoldColor(BuildContext context)=>
    UIParamenters.isDarkMode()?const Color(0xFF2e3c62):
    const Color.fromARGB(255, 240, 237, 255);

Color answerSelectedColor()=> UIParamenters.isDarkMode()?Theme.of(Get.context!).cardColor.withOpacity(0.5):
Theme.of(Get.context!).primaryColor;

Color answerBorderColor()=> UIParamenters.isDarkMode()?const Color.fromARGB(255, 20, 46, 158):const Color.fromARGB(255, 221, 221, 221);