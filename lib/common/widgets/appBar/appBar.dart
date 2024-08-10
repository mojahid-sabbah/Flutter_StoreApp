import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class appBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showbackarrow;
  final bool? IconData;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;

  const appBarWidget(
      {super.key,
      this.title,
      this.showbackarrow = false,
      this.IconData,
      this.actions,
      this.leadingOnPress});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showbackarrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon:   Icon(Iconsax.arrow_left , color: dark? TColors.white:TColors.black,))
            : leadingOnPress != null
                ? IconButton(
                    onPressed: leadingOnPress,
                    icon: const Icon(Iconsax.arrow_left))
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
