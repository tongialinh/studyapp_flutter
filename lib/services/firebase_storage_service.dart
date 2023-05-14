
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/firebase_ref/references.dart';

import '../app_logger.dart';



class FirebaseStorageService extends GetxService{
  Future<String?> getImage(String? imgName) async {
    if(imgName == null){
      return null;
    }
    try {
      var urlRef= firebaseStorage
          .child("question_paper_images")
          .child('${imgName.toLowerCase()}.png');

      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    }  on Exception catch (e) {
      AppLogger.e(e);
      return null;
    }
  }
  Future<String?> getImageQues(String? imgNameQues) async {
    if(imgNameQues == null){
      return null;
    }
    try {
      var urlRef= firebaseStorage
          .child("question_paper_images_ques")
          .child('${imgNameQues.toLowerCase()}.png');

      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    }  on Exception catch (e) {
     // AppLogger.e(e);
      return null;
    }
  }
}