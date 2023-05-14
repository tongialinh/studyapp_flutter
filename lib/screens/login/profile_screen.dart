import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/configs/themes/custom_text_styles.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/controllers/profile_controller.dart';
import 'package:studyapp_flutter/widgets/common/background_decoration.dart';
import 'package:studyapp_flutter/widgets/common/content_area.dart';
import 'package:studyapp_flutter/widgets/questions/recent_question_card.dart';

import '../../widgets/common/custom_app_bar.dart';

class ProfileScreen extends GetView<ProfileController>{
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final AuthController _auth = Get.find<AuthController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: UIParamenters.mobileScreenPadding.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children:  [
                      CircleAvatar(
                        radius: 35,
                        foregroundImage: NetworkImage(_auth.getUser()!.photoURL!),
                      ),
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        _auth.getUser()!.displayName ?? '',
                        style: headerText,
                      )
                    ],

                  ),
                  _DrawerButton(icon: Icons.logout, label: "Logout", onPressed: ()=>controller.signOut(),),
                 /* const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'My recent tests ',
                      style: TextStyle(
                          color: onSurfaceTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),*/
                ],
              ),
            ),
          /*  Expanded(
              child: Obx(
                    () =>  ContentArea(
                  addPadding: false,
                  child: ListView.separated(
                    padding: UIParamenters.mobileScreenPadding,
                    itemCount: controller.allRecentTest.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecentQuestionCard(recentTest: controller.allRecentTest[index]);
                    },
                  ),
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
class _DrawerButton extends StatelessWidget {
  const _DrawerButton({Key? key,
    required this.icon,
    required this.label,
    this.onPressed
  }) : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
            icon,
            size: 18
        ),
        label: Text(label));
  }
}


