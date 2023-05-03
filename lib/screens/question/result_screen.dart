import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_light_theme.dart';
import 'package:studyapp_flutter/configs/themes/custom_text_styles.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';
import 'package:studyapp_flutter/controllers/question_papers/questions_controller.dart';
import 'package:studyapp_flutter/controllers/question_papers/questions_controller_extension.dart';
import 'package:studyapp_flutter/screens/question/answer_check_screen.dart';
import 'package:studyapp_flutter/widgets/common/background_decoration.dart';
import 'package:studyapp_flutter/widgets/common/custom_app_bar.dart';
import 'package:studyapp_flutter/widgets/common/main_button.dart';
import 'package:studyapp_flutter/widgets/common/content_area.dart';
import 'package:studyapp_flutter/widgets/questions/answer_card.dart';
import 'package:studyapp_flutter/widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);
  static const String routeName = "/resultscreen";

  @override
  Widget build(BuildContext context) {
    Color _textColor =
    Get.isDarkMode ? Colors.white : primaryColorLight2;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          leading: const SizedBox(height: 80,),
          title: controller.correctAnsweredQuestions,
        ),
        body: BackgroundDecoration(
            child: Column(
              children: [

                Expanded(
                    child: ContentArea(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/6.png",
                            width: 200,
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 5),
                            child: Text(
                              'Congratulation',
                              style: headerText.copyWith(color: _textColor),
                            ),
                          ),
                          Text(
                            'you have ${controller.points} points',
                            style: TextStyle(color: _textColor),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Tap below question number to view correct answers',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Expanded(
                              child: GridView.builder(
                                  itemCount: controller.allQuestions.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: Get.width ~/ 75,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                                  itemBuilder: (_, index) {
                                    final _question = controller.allQuestions[index];
                                    AnswerStatus _status = AnswerStatus.notanswered;
                                    final _selectedAnswer = _question.selectedAnswer;
                                    final _correctAnswer = _question.correctAnswer;
                                    if (_selectedAnswer == _correctAnswer) {
                                      _status = AnswerStatus.correct;
                                    } else if (_question.selectedAnswer == null) {
                                      _status = AnswerStatus.wrong;
                                    } else {
                                      _status = AnswerStatus.wrong;
                                    }
                                    return QuestionNumberCard(
                                        index: index + 1,
                                        status: _status,
                                        onTap: () {
                                          controller.jumpToQuestion(index, isGoBack: false);
                                          Get.toNamed(AnswerCheckScreen.routeName);
                                        });
                                  }
                              ))
                        ],
                      ),
                    )),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParamenters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: MainButton(
                            onTap: (){
                              controller.tryAgain();
                            },

                            title: 'Try Again',
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Expanded(
                          child: MainButton(
                            onTap: (){
                              controller.saveTestResults();
                            },
                            title: 'Go home',
                            color: primaryColorLight,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}