import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';

enum AnswerStatus{
  correct, wrong, answered, notanswered
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard({Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParamenters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParamenters.cardBorderRadius,
            color: isSelected?answerSelectedColor():Theme.of(context).cardColor,
            border: Border.all(
              color: isSelected?answerSelectedColor():answerBorderColor(),
            )
        ),
        child: Text(
          answer,
          style: TextStyle(color: isSelected? onSurfaceTextColor:null),
        ),
      ),

    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({Key? key, required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration:  BoxDecoration(
          borderRadius: UIParamenters.cardBorderRadius,
          color: correctAnserColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: correctAnserColor,fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
class WrongAnswer extends StatelessWidget {
  const WrongAnswer({Key? key, required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration:  BoxDecoration(
          borderRadius: UIParamenters.cardBorderRadius,
          color: wrongAnswerColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: wrongAnswerColor,fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
class NotAnswered extends StatelessWidget {
  const NotAnswered({Key? key, required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration:  BoxDecoration(
          borderRadius: UIParamenters.cardBorderRadius,
          color: notAnsweredColr.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: notAnsweredColr,fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}