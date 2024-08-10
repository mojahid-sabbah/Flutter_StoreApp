import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/authentication_repositry.dart';
import 'package:t_store/data/repositories/userRepositry.dart';
import 'package:t_store/features/authentication/screens/verfiy_email/verfiy_email.dart';
import 'package:t_store/features/personalization/models/userModel.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/FullScreenLoader.dart';

class SignUpControllers extends GetxController {
  static SignUpControllers get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final emailController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final phoneController = TextEditingController();

  GlobalKey<FormState> signupformkey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'We are processing your information', TImages.productsIllustration);
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        return;
      }
      print("//****connected ******* errrrrroooorrrr");

      if (signupformkey.currentState != null &&
          signupformkey.currentState!.validate()) {
        print("//*********signupformkey**** ******* errrrrroooorrrr");
        return;
      }
      // if (signupformkey.currentState!.validate()) {
      // print("//********************************** errrrrroooorrrr");
      //   return;
      // }

      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create acount , you have to read and accept');
        return;
      }
// Regester
      final userCredential = await AuthenticationRepositry.instance
          .RegesterWithEmailPassword(
              emailController.text.trim(), passwordController.text.trim());

      if (userCredential.user != null) {
        final newUser = UserModel(
            id: userCredential.user!.uid,
            firstName: firstnameController.text,
            lastName: lastnameController.text,
            userName: usernameController.text,
            email: emailController.text,
            password: passwordController.text,
            phone: phoneController.text,
            ProfilePicture: '');

        final userRepository = Get.put(UserRepositry()); // here we created an object from (class UserRepositry()  )
        await userRepository.saveUserRecored(newUser);
      } else {
        print("//**************if else******* errrrrroooorrrr");
      }

      TLoaders.successSnackBar(
          title: 'Congratulation',
          message:
              'Your Account has been created , pls verfiy email to continue');
      Get.to(() => const Verfiy_Email());
    } catch (e) {
      FullScreenLoader.stopLoading();
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    }
  }



}
