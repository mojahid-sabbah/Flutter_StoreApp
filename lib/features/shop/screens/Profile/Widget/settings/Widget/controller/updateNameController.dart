import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/userRepositry.dart';
import 'package:t_store/features/personalization/controllers/UserController.dart';
import 'package:t_store/features/shop/screens/Profile/ProfilePage.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/FullScreenLoader.dart';

class updateNameControllers extends GetxController {
  static updateNameControllers get instance => Get.find();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final userController = UserController.instance;
  final userRepositry = Get.put(UserRepositry());
  GlobalKey<FormState> updateNameformkey = GlobalKey<FormState>();
  @override
  void onInit() {
     super.onInit();
    initialzeName();
  }

  Future<void> initialzeName() async {
    firstname.text = userController.userr.value.firstName ?? '';
    lastname.text = userController.userr.value.lastName ?? '';
  }

  Future<void> updateUserName() async {
    try {
      // FullScreenLoader.openLoadingDialog( 'We are processing your information', TImages.productsIllustration);
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();

        return;
      }

      if (updateNameformkey.currentState != null &&
          updateNameformkey.currentState!.validate()) {
        print("//*********updateNameformkey**** ******* errrrrroooorrrr");
        FullScreenLoader.stopLoading();

        return;
      }

      //********************************************************************* */
//update first + last username value in firebase firestore
      Map<String, dynamic> name = {
        'firstName': firstname.text.trim(),
        'lastName': lastname.text.trim()
      };
      await userRepositry.updateUserField(name);

      // update rx user value
      userController.userr.value.firstName = firstname.text.trim();
      userController.userr.value.lastName = lastname.text.trim();
      FullScreenLoader.stopLoading();
//**************************************************************************** */

      TLoaders.successSnackBar(
          title: 'Congratulation', message: 'Your name has been updated ');
      Get.off(() => const ProfilePage());
    } catch (e) {
      FullScreenLoader.stopLoading();
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    }
  }
}
