import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/app_logger.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/firebase_ref/references.dart';
import 'package:studyapp_flutter/models/question_paper_model.dart';
import 'package:studyapp_flutter/screens/question/question_screen.dart';
import 'package:studyapp_flutter/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["biology", "chemistry", "maths", "physics"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl =
        await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }
  void navigateToQuestions({required QuestionPaperModel paper, bool tryAgain=false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        Get.offNamed(QuestionsScreen.routeName, arguments: paper, preventDuplicates: false);
      }else{

        Get.toNamed(QuestionsScreen.routeName, arguments: paper);
      }
    }else{

      _authController.showLoginAlertDialogue();
    }
  }
}