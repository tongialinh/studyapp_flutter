import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studyapp_flutter/app_logger.dart';
import 'package:studyapp_flutter/firebase_ref/references.dart';
import 'package:studyapp_flutter/screens/home/home_screen.dart';
import 'package:studyapp_flutter/screens/login/login_screen.dart';
import 'package:studyapp_flutter/widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController{
  @override
  void onReady(){
    initAuth();
    super.onReady();
  }
  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;


  void initAuth() async {
    await Future.delayed(const Duration(seconds: 7));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  Future<void> signInWithGoogle() async  {
    final GoogleSignIn _googleSignIn =  GoogleSignIn();
    try{
      GoogleSignInAccount? account = await  _googleSignIn.signIn();
      if(account!=null){
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken);

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    }on Exception catch(error){
      AppLogger.e(error);
    }
  }


  Future<void> signOut() async {
    AppLogger.d('Sign out');
    try{
      await _auth.signOut();
      navigateToHomePage();
    }on FirebaseAuthException catch(e){
      AppLogger.e(e);
    }
  }
  Future<void> saveUser(GoogleSignInAccount account) async{
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }

  User? getUser(){
    _user.value = _auth.currentUser;
    return _user.value;
  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }

  void navigateToIntroduction(){
    Get.offAllNamed("/introduction");

  }
  void navigateToHomePage(){
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialogue(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();
    }),
        barrierDismissible: false
    );
  }

  void navigateToLoginPage(){
    Get.toNamed(LoginScreen.routeName);
  }


}
