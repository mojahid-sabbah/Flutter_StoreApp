


import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/CircularIcon/CircularIcon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductCountAddRemove extends StatelessWidget {
  const ProductCountAddRemove({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircularIcon(
          icon: Iconsax.minus,
          backgroundColor: TColors.darkGrey,
          width: 40,
          height: 40,
          color: TColors.white,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text(
          "2",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        CircularIcon(
          icon: Iconsax.add,
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.black,
          width: 40,
          height: 40,
          color: TColors.white,
        ),
      ],
    );
  }
}
