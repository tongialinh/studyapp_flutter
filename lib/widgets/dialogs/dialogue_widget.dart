import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Dialogs{
  static final Dialogs _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs(){
    return _singleton;
  }

  static Widget questionStartDialogue({required VoidCallback onTap}){
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Hi...",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text("Please login before you start")
        ],
      ),
      actions: [
        TextButton(onPressed: onTap, child: const Text("Confirm"))
      ],
    );
  }
  static Future<bool> quizEndDialog() async{
    return (await showDialog(
      context: Get.overlayContext!,
      builder: (context) =>  AlertDialog(
        title:  const Text('Are you sure?'),
        content:  const Text('Do you want to exit the quiz without completing it ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>  Get.back(result: false),
            child:  const Text('No'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child:  const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;

  }
}