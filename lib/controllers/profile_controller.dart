import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/app_logger.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/firebase_ref/references.dart';
import 'package:studyapp_flutter/models/question_paper_model.dart';
import 'package:studyapp_flutter/models/recent_papers.dart';
import 'package:studyapp_flutter/services/firebase_storage_service.dart';

class ProfileController extends GetxController {
  @override
  void onReady() {
    getMyRecentTests();
    super.onReady();
  }
  void signOut() {
    Get.find<AuthController>().signOut();
  }
  void signIn() {
    Get.find<AuthController>().navigateToLoginPage();
  }


  final allRecentTest = <RecentTest>[].obs;

  getMyRecentTests() async {
    try {
      User? user = Get.find<AuthController>().getUser();
      if (user == null) return;
      QuerySnapshot<Map<String, dynamic>> data =
      await recentQuestions(userId: user.email!).get();
      final tests =
      data.docs.map((paper) => RecentTest.fromSnapshot(paper)).toList();

      for (RecentTest test in tests) {
        DocumentSnapshot<Map<String, dynamic>> questionPaperSnaphot =
        await questionPaperRF.doc(test.paperId).get();
        final questionPaper = QuestionPaperModel.fromSnapshot(questionPaperSnaphot);

        final url =  await Get.find<FirebaseStorageService>().getImage(questionPaper.title);
        test.papername = questionPaper.title;
        test.paperimage = url;
      }

      allRecentTest.assignAll(tests);
    } catch (e) {
      AppLogger.e(e);
    }
  }
}
