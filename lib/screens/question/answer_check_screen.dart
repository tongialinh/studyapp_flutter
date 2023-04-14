import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/custom_text_styles.dart';
import 'package:studyapp_flutter/controllers/question_papers/questions_controller.dart';
import 'package:studyapp_flutter/screens/question/result_screen.dart';
import 'package:studyapp_flutter/widgets/common/background_decoration.dart';
import 'package:studyapp_flutter/widgets/common/custom_app_bar.dart';
import 'package:studyapp_flutter/widgets/content_area.dart';
import 'package:studyapp_flutter/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({Key? key}) : super(key: key);
  static String routeName = "/answerchechscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
                ()=>Text(
              'Question ${(controller.questionIndex.value+1).toString()
                  .padLeft(2, "0")}',
              style: appBarTS,
            )
        ),
        showActionIcon: true,
        onMenuActionTap: (){
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
                ()=>Column(
              children: [
                Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top:25),
                        child: Column(
                          children: [
                            Text(
                                controller.currentQuestion.value!.question,
                              style: questionTS,
                            ),
                            GetBuilder<QuestionsController>(
                                id: 'answer_review_list',
                                builder:(_){
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index){
                                        final answer = controller.currentQuestion.value!.answers[index];
                                        final selectedAnswer =  controller.currentQuestion.value!.selectedAnswer;
                                        final correctAnswer = controller.currentQuestion.value!.correctAnswer;
                                        final String answerText =
                                            '${answer.identifier}. ${answer.answer}';
                                        if(correctAnswer == selectedAnswer &&
                                            answer.identifier == selectedAnswer){
                                          return CorrectAnswer(answer: answerText);
                                        }else if(selectedAnswer==null){
                                          return NotAnswered(answer: answerText);
                                        }else if(correctAnswer != selectedAnswer &&
                                            answer.identifier == selectedAnswer){
                                          return WrongAnswer(answer: answerText);
                                        }else if(correctAnswer==answer.identifier){
                                          return CorrectAnswer(answer: answerText);
                                        }
                                        return AnswerCard(
                                          answer: answerText,
                                          onTap: (){},
                                          isSelected:  false,
                                        );
                                      },
                                      separatorBuilder: (_, index){
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount: controller.currentQuestion.value!.answers.length);
                                })
                          ],
                        ),
                      ),
                    ) )
              ],
            )
        ),
      ),
    );
  }
}
