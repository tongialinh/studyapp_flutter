import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/configs/themes/custom_text_styles.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/widgets/common/main_button.dart';

class AppIntroductionScreen extends GetView<AuthController>{
  const AppIntroductionScreen ({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/5.png",
              width: 300,
              height: 300,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Unlock your knowledge with our interactive quizzes!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900, fontSize: 20),textAlign: TextAlign.center,


              ),
            ),
            const SizedBox(height: 40),
            MainButton(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              color: Colors.blueAccent,
              child: Stack(
                children: const [
                  Center(
                    child: Text(
                      "Get Stared",

                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            MainButton(
              onTap: () {
                controller.signInWithGoogle();
              },
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 10,
                      child: SvgPicture.asset("assets/icons/google.svg")),
                  const Center(
                    child: Text(
                      "Sign in with google",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
          ],),),

    );
  }
}
class CircleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Icon(Icons.arrow_forward, size: 35),
    );
  }
}