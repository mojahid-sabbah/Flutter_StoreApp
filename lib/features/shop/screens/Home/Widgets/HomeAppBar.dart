import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/personalization/controllers/UserController.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.homeAppbarSubTitle = TTexts.homeAppbarSubTitle,
    this.homeAppbarTitle = TTexts.homeAppbarTitle,
    this.Actions,
  });
  final String homeAppbarSubTitle;
  final String homeAppbarTitle;
  final List<Widget>? Actions;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(UserController());

    return appBarWidget(
        // app bar 2 title +  Counter cart
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: dark ? TColors.grey : TColors.white),
            ),
            Obx(() {
              if (controller.profileLoading.value) {
                return const CircularProgressIndicator(); //shimmer effect lesson >> 21 minute 
              } else {
                return Text(
                  controller.userr.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: dark ? TColors.white : TColors.white),
                );
              }
            })
          ],
        ),
        actions: Actions);
  }
}
