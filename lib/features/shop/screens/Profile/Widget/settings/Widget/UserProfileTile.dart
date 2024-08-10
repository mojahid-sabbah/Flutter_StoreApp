import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/Images/CircularStoreImage.dart';
import 'package:t_store/features/personalization/controllers/UserController.dart';
import 'package:t_store/features/shop/screens/Profile/ProfilePage.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.userr.value.ProfilePicture;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
        return controller.imageUploader.value
            ? const CircularProgressIndicator()
            : CircularStoreImage(
                image: image,
                padding:   const EdgeInsets.all(2),
                fit: BoxFit.cover,
                
                isNetWorkImage: networkImage.isNotEmpty,
              );
      }),
      title: Text(
        controller.userr.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        controller.userr.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: () {
            Get.to(() => const ProfilePage());
          },
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
    );
  }
}
