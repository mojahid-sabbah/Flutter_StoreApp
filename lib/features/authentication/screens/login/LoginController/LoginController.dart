 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/authentication_repositry.dart';
import 'package:t_store/features/personalization/controllers/UserController.dart';
 import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/FullScreenLoader.dart';

class LoginControllers extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // after you sign out you back to login secreen this code read saved email and password and write it in failds
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ??'';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD')??'';
    super.onInit();
  }

  Future<void> Signin_EmailPass() async {
    try {
      // FullScreenLoader.openLoadingDialog(
      //     'Logging you in ...', TImages.productsIllustration);
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        print("//****connected ******* errrrrroooorrrr");
        FullScreenLoader.stopLoading();

        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        print("//*********loginformkey**** ******* errrrrroooorrrr");
        FullScreenLoader.stopLoading();

        return;
      }
      // save data in storage if rememberMe == true
      if (rememberMe.value) {
        print("//*********rememberMe**** ******* errrrrroooorrrr");

        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      print("//*********userCredential**** *******  --------------");

      final userCredential = await AuthenticationRepositry.instance
          .Login(email.text.trim(), password.text.trim());

      // remove loader
      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Congratulation',
          message: 'Your Account has been signed in , enjoy ^_^`');

      AuthenticationRepositry.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    }
  }

  Future<void> Signin_Google() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        print("//****connected ******* errrrrroooorrrr");
        FullScreenLoader.stopLoading();
        return;
      }
      // google auth
      final userCredential =   await AuthenticationRepositry.instance.signInByGoogle();

      if (userCredential  != null) {
        
      // saveed User Data
      await UserController.instance.saveUserRecored(userCredential);
      // remove loader
      FullScreenLoader.stopLoading();
      // Redirect
      AuthenticationRepositry.instance.screenRedirect();
      } else {
      // Handle null userCredential
      print("Authentication failed.");
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Sign-in Error:', message: 'Failed to sign in with Google.');
    }
    } catch (e) {
      FullScreenLoader.stopLoading();
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    }
  }
} 