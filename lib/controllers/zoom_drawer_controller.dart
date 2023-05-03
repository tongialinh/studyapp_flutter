import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/screens/leaderboard/leaderboard_screen.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }
  void signIn() {
    Get.find<AuthController>().navigateToLoginPage();
  }

  void score() {

    Get.toNamed(LeaderBoardScreen.routeName);
  }
  /*void facebook() {
    _launch(("https://www.facebook.com"));
  }

  void email() {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'tgl@gmail.com'
    );
    _launch(emailLaunchUri.toString());
  }*/

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'could not launch $url';
    }
  }

  launch(String url) {}
}
