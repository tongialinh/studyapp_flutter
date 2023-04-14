import 'package:get/get.dart';
import 'package:studyapp_flutter/controllers/auth_controller.dart';
import 'package:studyapp_flutter/controllers/theme_controller.dart';
import 'package:studyapp_flutter/services/firebase_storage_service.dart';

class InitialBindings implements Bindings{

  @override
  void dependencies(){
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() =>  FirebaseStorageService());


  }
}