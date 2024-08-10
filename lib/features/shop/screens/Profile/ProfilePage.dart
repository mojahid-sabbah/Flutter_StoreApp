import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/Images/CircularStoreImage.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/personalization/controllers/UserController.dart';
import 'package:t_store/features/shop/screens/Profile/Widget/ProfileMenu.dart';
import 'package:t_store/features/shop/screens/Profile/Widget/settings/Widget/changeName.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const appBarWidget(
        showbackarrow: true,
        title: Text("Profile Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage =
                          controller.userr.value.ProfilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;
                     return controller.imageUploader.value
                          ? const CircularProgressIndicator()
                          : CircularStoreImage(
                              image: image,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                              isNetWorkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                        onPressed: () {
                          controller.uploadUserProfilePicture();
                        },
                        child: const Text("Change Profile Picture")),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const sectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                onPressed: () => Get.to(() => const changeName()),
                title: 'Name ',
                value: controller.userr.value.fullName,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'User Name ',
                value: controller.userr.value.userName ?? '',
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const sectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              //-------------------------------------------------------------------
              ProfileMenu(
                onPressed: () {},
                title: 'User ID ',
                value: controller.userr.value.id ?? "",
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'E_mail',
                value: controller.userr.value.email,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'Phone Number ',
                value: controller.userr.value.phone,
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'Gender ',
                value: 'male ',
              ),
              ProfileMenu(
                onPressed: () {},
                title: 'Date of Birth ',
                value: '2 Feb,  1996 ',
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Close Account",
                    style: TextStyle(color: Colors.red, fontSize: TSizes.md),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
