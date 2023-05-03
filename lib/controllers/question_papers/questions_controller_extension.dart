import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/controllers/question_papers/questions_controller.dart';
import 'package:studyapp_flutter/firebase_ref/references.dart';


extension QuestionsControllerExtension on QuestionsController{

  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer== element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions{
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points{
    var points = (correctQuestionCount/allQuestions.length)*100*
        (questionPaperModel.timeSeconds - remainSeconds)/questionPaperModel.timeSeconds*100;
    return points.toStringAsFixed(2);
  }
  Future<void> saveTestResults() async{
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if(_user==null) return;
    batch.set(
        userRF.doc(_user.email)
            .collection('myrecent_tests')
            .doc(questionPaperModel.id),
        {
          "points":points,
          "correct_answers": '$correctQuestionCount/${allQuestions.length}',
          "question_id": questionPaperModel.id,
          'time': questionPaperModel.timeSeconds-remainSeconds
        }
    );
    batch.set(
        leaderBoardRF
            .doc(questionPaperModel.id)
            .collection('scores')
            .doc(_user.email),
        {
          "points": double.parse(points),
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": questionPaperModel.id,
          "user_id": _user.email,
          "time": questionPaperModel.timeSeconds - remainSeconds
        });
    await batch.commit();
    // Get.find<NotificationService>().showQuizCompletedNotification(
    //     id: 1,
    //     title: questionPaperModel.title,
    //     body:  'You have just got $points points for ${questionPaperModel.title} -  Tap here to view leaderboard' ,
    //     imageUrl: questionPaperModel.imageUrl,
    //     payload: json.encode(questionPaperModel.toJson()));
    navigateHome();
  }
}