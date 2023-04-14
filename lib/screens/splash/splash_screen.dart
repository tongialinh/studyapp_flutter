import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/controllers/question_papers/data_uploader.dart';
import 'package:studyapp_flutter/firebase_ref/loading_status.dart';


class SplashScreen extends StatelessWidget{
   SplashScreen({Key ? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment:  Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/2.png" ,
                  width: 250,height: 250),
              Obx(()=>Text(controller.loadingStatus.value== LoadingStatus.completed
                  ? "Let's gooo!"
                  : "Loading...",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900, fontSize: 20)
              ),),
            ],
          ),


        ));
  }

}