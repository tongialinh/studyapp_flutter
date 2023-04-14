import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/configs/themes/app_icons.dart';
import 'package:studyapp_flutter/configs/themes/custom_text_styles.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/controllers/question_papers/question_paper_controller.dart';
import 'package:studyapp_flutter/controllers/zoom_drawer_controller.dart';
import 'package:studyapp_flutter/screens/home/menu_screen.dart';
import 'package:studyapp_flutter/screens/home/question_card.dart';
import 'package:studyapp_flutter/widgets/app_circle_button.dart';
import 'package:studyapp_flutter/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();

    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_){
        return ZoomDrawer(
          borderRadius: 50.0,
          controller: _.zoomDrawerController,
          showShadow: true,
          angle: 0.0,
          style: DrawerStyle.defaultStyle,
          menuBackgroundColor: Colors.white.withOpacity(0.5),
          slideWidth: MediaQuery.of(context).size.width*1,

          menuScreen: MyMenuScreen(),
          mainScreen: Container(
            decoration: BoxDecoration(gradient: mainGradient()),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCircleButton(

                          child: const Icon(AppIcons.menuLeft,),
                          onTap: controller.toogleDrawer,
                        ),

                        const SizedBox(
                          height: 10,

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const Icon(AppIcons.peace),
                              Builder(
                                builder: (_){
                                  final AuthController _auth = Get.find();
                                  final user = _auth.getUser();
                                  String _label = 'Hello mate';
                                  if(user!= null){
                                    _label = '  Hello ${user.displayName}';
                                  }
                                  return Text(_label, style: detailText.copyWith(color: onSurfaceTextColor, fontWeight: FontWeight.w700,));
                                }

                              ),

                             /* Text(
                                "Hello ",
                                style:
                                detailText.copyWith(color: onSurfaceTextColor, fontWeight: FontWeight.w700),
                              )*/
                            ],
                          ),
                        ),
                        const Text(
                          "What do you want to learn today?",
                          style: headerText,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: ContentArea(
                        addPadding: false,
                        child: Obx(() => ListView.separated(
                          padding: UIParamenters.mobileScreenPadding,
                          itemCount: _questionPaperController.allPapers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return QuestionCard(
                              model: _questionPaperController.allPapers[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },),


    );
  }
}