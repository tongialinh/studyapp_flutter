import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/configs/themes/app_colors.dart';
import 'package:studyapp_flutter/configs/themes/ui_parameters.dart';
import 'package:studyapp_flutter/controllers/zoom_drawer_controller.dart';
import 'package:studyapp_flutter/screens/login/profile_screen.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParamenters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(textButtonTheme:
        TextButtonThemeData(
            style: TextButton.styleFrom(primary: onSurfaceTextColor)
        )),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 5,
                  right: 0,
                  child: BackButton(
                    color: onSurfaceTextColor,
                    onPressed: (){
                      controller.toogleDrawer();
                    },
                  )),
              Padding(
                padding:  EdgeInsets.only(
                   // right: MediaQuery.of(context).size.width*0.3,
                  top: 0,
                  left: 10,
                  bottom: 20,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   /* Obx(()=>controller.user.value==null?
                    const SizedBox()
                        :Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                      controller.user.value!.displayName??'',
                      style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color:onSurfaceTextColor
                      ),
                    ),
                        )),*/
                    Obx(() => controller.user.value == null
                        ? TextButton.icon(
                        icon: const Icon(Icons.login_rounded),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            elevation: 0,
                            backgroundColor: Colors.white.withOpacity(0.5),
                            primary: Colors.white),
                        onPressed: () {
                          controller.signIn();
                        },
                        label: const Text("Sign in"))
                        : GestureDetector(
                      onTap: () {
                        Get.toNamed(ProfileScreen.routeName);},
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 12, bottom: 10),
                          child: CircleAvatar(
                            foregroundImage:
                            controller.user.value!.photoURL == null
                                ? null
                                : NetworkImage(
                                controller.user.value!.photoURL!),
                            backgroundColor: Colors.white,
                            radius: 20,
                          ),
                        ),
                      ),
                    )),
                    Obx(
                          () => controller.user.value == null
                          ? const SizedBox()
                          : Text(controller.user.value!.displayName ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: onSurfaceTextColor)),
                    ),
                   // const Spacer(flex: 1,),
                    _DrawerButton(icon: Icons.school_outlined, label: "Score", onPressed: ()=>controller.score(),),
                   /* _DrawerButton(icon: Icons.facebook, label: "facebook", onPressed: ()=>controller.facebook(),),
                    _DrawerButton(icon: Icons.email, label: "email", onPressed: ()=>controller.email(),),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: _DrawerButton(icon: Icons.email, label: "email", onPressed: ()=>controller.email(),),
                    ),*/
                    const Spacer(flex: 4),
                    _DrawerButton(icon: Icons.logout, label: "Logout", onPressed: ()=>controller.signOut(),),
                  ],
                ),
              )
            ],
          ),
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

