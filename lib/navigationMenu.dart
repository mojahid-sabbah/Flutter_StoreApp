import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/screens/Home/HomePage.dart';
import 'package:t_store/features/shop/screens/Store/Store.dart';
import 'package:t_store/features/shop/screens/Profile/Widget/settings/SettingsScreen.dart';
import 'package:t_store/features/shop/screens/wishList/wishList.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(  () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,

          ///------------------------------
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: dark ? TColors.black : TColors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
            NavigationDestination(icon: Icon(Iconsax.heart), label: "wishlist"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "profile")
          ],
        ),
      ),
      //------------------------------------------------------------------------
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const StorePage(),
    const wishListPage(),
    const SettingsScreen()
  ];
}
