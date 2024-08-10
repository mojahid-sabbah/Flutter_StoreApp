import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/common/widgets/success_secreen/success_secreen.dart';
import 'package:t_store/data/repositories/authentication_repositry.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  @override
  void onInit() {
    sendEmailVerification();
    setTimerofRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepositry.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: ' please Check your inbox and verify your email');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap @@!', message: e.toString());
    }
  }

  setTimerofRedirect() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => success_secreen(
              image: TImages.staticSuccessIllustration,
              title: TTexts.yourAccountCreatedTitle,
              subTitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepositry.instance.screenRedirect(),
            ));
      }
    });
  }

  CheckEmailVerfification() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => success_secreen(
              image: TImages.staticSuccessIllustration,
              title: TTexts.yourAccountCreatedTitle,
              subTitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepositry.instance.screenRedirect(),
            )); 
    }
  }
}
