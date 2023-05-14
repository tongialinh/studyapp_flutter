import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_light_theme.dart';
import 'package:studyapp_flutter/controllers/question_papers/questions_controller.dart';
import 'package:studyapp_flutter/models/question_paper_model.dart';

class QuestionDetailCard extends GetView<QuestionsController> {
  const QuestionDetailCard({Key? key, required this.model}) : super(key: key);
  final Questions model;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 170,
            width: 200,
            //child: model.imageUrl == null ||  model.imageUrl!.isEmpty ? null : Image.network(model.imageUrl!),
            child: CachedNetworkImage(
              imageUrl: model.imageUrlQues?.isNotEmpty == true ? model.imageUrlQues! : '',
              placeholder: (context, url) => Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/app_splash_logo.png"),
            ),
          ),
        )
    );
  }
}
