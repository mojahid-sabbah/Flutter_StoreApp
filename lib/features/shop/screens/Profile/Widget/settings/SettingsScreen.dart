import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/containers/PrimaryHeaderContainer.dart';
import 'package:t_store/common/widgets/productsCart/CartCounterWidget.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/data/repositories/authentication_repositry.dart';
import 'package:t_store/features/authentication/screens/addCategories/addCategories.dart';
import 'package:t_store/features/shop/screens/AddProducts/AddProducts.dart';
import 'package:t_store/features/shop/screens/Home/Widgets/HomeAppBar.dart';
import 'package:t_store/features/shop/screens/MyAddress/MyAddress.dart';
import 'package:t_store/features/shop/screens/Order/Order.dart';
import 'package:t_store/features/shop/screens/Profile/Widget/settings/Widget/SettingMenuTile.dart';
import 'package:t_store/features/shop/screens/Profile/Widget/settings/Widget/UserProfileTile.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PrimaryHeaderContainer(
                child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: HomeAppBar(
                      homeAppbarSubTitle: "Account",
                      homeAppbarTitle: "",
                      Actions: [
                        // this icon Counter cart in app bar
                        CartCounterWidget(
                          
                        )
                      ],
                    )),
                UserProfileTile(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),
    //-----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const sectionHeading(
                    title: "Acount Settings",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingMenuTile(
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {
                        Get.to(() => const MyAddress());
                      },
                      icon: Iconsax.safe_home),
                  SettingMenuTile(
                      title: 'My Cart',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {},
                      icon: Iconsax.shopping_bag),
                  SettingMenuTile(
                      title: 'My Orders',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {
                        Get.to(() => const OrdersPage());
                      },
                      icon: Iconsax.bag_tick),
                  SettingMenuTile(
                      title: 'Bank Account',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {},
                      icon: Iconsax.bank),
                  SettingMenuTile(
                      title: 'My Coupons',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {},
                      icon: Iconsax.discount_shape),
                  SettingMenuTile(
                      title: 'Notifications',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {},
                      icon: Iconsax.notification),
                  SettingMenuTile(
                      title: 'Account Privacy',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {},
                      icon: Iconsax.security_card),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const sectionHeading(
                    title: "App Settings",
                    showActionButton: false,
                  ),
                  SettingMenuTile(
                      title: 'Load Data',
                      subTitle: 'Upload Data to your Cloud Firebase',
                      onTap: () {},
                      icon: Iconsax.document_upload),
                  SettingMenuTile(
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    onTap: () {},
                    icon: Iconsax.location,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SettingMenuTile(
                      title: 'Safe Mode',
                      subTitle: 'search result is safe for all ages',
                      onTap: () {},
                      trailing: Switch(value: false, onChanged: (value) {}),
                      icon: Iconsax.security_user),
                  SettingMenuTile(
                      title: 'HD image Quality',
                      subTitle: 'Set image quality to be seen',
                      onTap: () {},
                      trailing: Switch(value: false, onChanged: (value) {}),
                      icon: Iconsax.image),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () { Get.to(()=>const addProducts());}, child: const Text("Add Products")),
                  ),
                   const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () { Get.to(()=>const addCategories());}, child: const Text("Add Categories")),
                  ),

                     const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),


                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {  AuthenticationRepositry.instance.Logout();}, child: const Text("LogOut")),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
