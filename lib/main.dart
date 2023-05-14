import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:studyapp_flutter/bindings/initial_bindings.dart';
import 'package:studyapp_flutter/controllers/theme_controller.dart';
import 'package:studyapp_flutter/data_uploader_screen.dart';
import 'package:studyapp_flutter/firebase_options.dart';
import 'package:studyapp_flutter/routes/app_routes.dart';
import 'package:studyapp_flutter/screens/introduction/introduction.dart';
import 'package:studyapp_flutter/screens/splash/splash_screen.dart';

/*void main(){
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp( MyApp());
}*/
class MyApp extends StatelessWidget{
  const MyApp ({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
     //  home: SplashScreen()
      getPages: AppRoutes.routes(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(const MyApp());
  //runApp(GetMaterialApp(home: DataUploaderScreen()));
}

