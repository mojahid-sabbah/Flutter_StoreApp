 
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/screens/login/LoginPage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
// variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatepageindicator(index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();

      if (kDebugMode) {
        print("kDebugMode >>>>>     ${storage.read('isFirstTime')} ");
      }

      storage.write('isFirstTime', false);
      Get.offAll(() =>const LoginPage());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
    nextPage();
  }
}
