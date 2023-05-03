import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/controllers/question_papers/question_paper_controller.dart';
import 'package:studyapp_flutter/firebase_ref/loading_status.dart';
import 'package:studyapp_flutter/firebase_ref/references.dart';
import 'package:studyapp_flutter/models/question_paper_model.dart';
import 'package:studyapp_flutter/screens/home/home_screen.dart';
import 'package:studyapp_flutter/screens/question/result_screen.dart';
import 'package:studyapp_flutter/widgets/dialogs/dialogue_widget.dart';

import '../../app_logger.dart';
import '../auth_controller.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestions => questionIndex.value >= allQuestions.length-1;

  Rxn<Questions> currentQuestion = Rxn<Questions>();
  //Timer
  Timer? _timer;
  int remainSeconds =1;
  final time = '00.00'.obs;


  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    print("...onReady...");
    loadData(_questionPaper);
    super.onReady();
  }
  @override
  void onClose() {
    if(_timer != null){
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<bool> onExitOfQuiz() async{
    return Dialogs.quizEndDialog( );
  }

  void _startTimer(int seconds){
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer =  Timer.periodic(duration, (Timer timer) {
      if(remainSeconds==0){
        timer.cancel();
      }else{
        int minutes = remainSeconds~/60;
        int seconds = remainSeconds%60;
        time.value = minutes.toString().padLeft(2, "0")+":"+seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }


  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
      await questionPaperRF
          .doc(questionPaper.id)
          .collection("questions")
          .get();
      final questions = questionQuery.docs.map((snapshot) => Questions
          .fromSnapshot(snapshot))
          .toList();

      questionPaper.questions = questions;
      for(Questions _question in questionPaper.questions!){
        final QuerySnapshot<Map<String,dynamic>> answersQuery =

        await questionPaperRF.doc(questionPaper.id)
            .collection("questions")
            .doc(_question.id)
            .collection("answer")
            .get();
        final answers = answersQuery.docs.map((answer) => Answers.fromSnapshot(answer))
            .toList();
        _question.answers = answers;

      }

    } on Exception  catch (e) {
      RegExp exp =  RegExp(r'permission-denied', caseSensitive: false, );
      if(e.toString().contains(exp)){
        AuthController _authController = Get.find();
        Get.back();
        _authController.showLoginAlertDialogue();
      }
      AppLogger.e(e);
      loadingStatus.value = LoadingStatus.error;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }

    if(questionPaper.questions!=null && questionPaper.questions!.isNotEmpty){
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      print("...start...");
      if (kDebugMode) {
        print(questionPaper.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    }else{
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer){
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list','answer_review_list']);
  }

  String get completedTest{
    final answered = allQuestions.where((element) =>
    element.selectedAnswer!=null)
        .toList().length;
    return '$answered out of ${allQuestions.length} answered';
  }

  void jumpToQuestion(int index, {bool isGoBack = true}){
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if(isGoBack){
      Get.back();
    }
  }

  void nextQuestion(){
    if(questionIndex.value >= allQuestions.length-1)
      return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];

  }

  void precQuestion(){
    if(questionIndex.value <= 0)
      return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }


  void complete(){
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain(){
    Get.find<QuestionPaperController>().navigateToQuestions(paper:
    questionPaperModel, tryAgain: true
    );
  }
  void navigateHome(){
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
