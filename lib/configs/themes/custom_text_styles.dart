import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/configs/themes/app_light_theme.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';

TextStyle cardTitles(context)=> TextStyle(
    color: UIParamenters.isDarkMode()
        ? Theme.of(context).textTheme.bodyText1!.color
        : primaryColorLight2,
    fontSize: 18,
    fontWeight: FontWeight.bold
);
const questionTS = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(fontSize: 20, fontWeight: FontWeight.w800,
    color: onSurfaceTextColor);

const appBarTS = TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: onSurfaceTextColor);
TextStyle countDownTimerTS()=>TextStyle(
    letterSpacing: 2,
    color: UIParamenters.isDarkMode()?
    Theme.of(Get.context!).textTheme.bodyText1!.color
        :Theme.of(Get.context!).primaryColor
);