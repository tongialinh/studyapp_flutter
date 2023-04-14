import 'package:get/get.dart';
import 'package:studyapp_flutter/controllers/question_papers/question_paper_controller.dart';
import 'package:studyapp_flutter/controllers/question_papers/questions_controller.dart';
import 'package:studyapp_flutter/controllers/zoom_drawer_controller.dart';
import 'package:studyapp_flutter/screens/home/home_screen.dart';
import 'package:studyapp_flutter/screens/introduction/introduction.dart';
import 'package:studyapp_flutter/screens/login/login_screen.dart';
import 'package:studyapp_flutter/screens/question/answer_check_screen.dart';
import 'package:studyapp_flutter/screens/question/question_screen.dart';
import 'package:studyapp_flutter/screens/question/result_screen.dart';
import 'package:studyapp_flutter/screens/question/test_overview_screen.dart';
import 'package:studyapp_flutter/screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
  GetPage(name: "/", page: () =>  SplashScreen()),
  GetPage(
  name: "/introduction",
      page: () => const AppIntroductionScreen()),
    GetPage(
        name: "/home",
        page: () => const HomeScreen(),
        binding: BindingsBuilder(() {
          Get.put(QuestionPaperController());
          Get.put(MyZoomDrawerController());
        })),
    GetPage(
        name: LoginScreen.routeName,
        page: ()=>LoginScreen()
    ),
    GetPage(
        name: QuestionsScreen.routeName,
        page: ()=>QuestionsScreen(),
        binding: BindingsBuilder((){
          Get.put<QuestionsController>(QuestionsController());
        })
    ),
    GetPage(
        name: TestOverviewScreen.routeName ,
        page: ()=>const TestOverviewScreen()
    ),
    GetPage(
        name: ResultScreen.routeName ,
        page: ()=>const ResultScreen()
    ),
    GetPage(
        name: AnswerCheckScreen.routeName ,
        page: ()=>const AnswerCheckScreen()
    )
  ];
}
