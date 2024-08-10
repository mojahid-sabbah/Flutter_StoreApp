import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/BrandTitle_verifyIcon/BrandTitle_verifyIcon.dart';
import 'package:t_store/common/widgets/Images/CircularStoreImage.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/features/shop/models/brandsModel.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder,
    this.onTap, required this.brand,
  });
  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircularContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        backgroundColor: Colors.transparent,
        showBorder: showBorder,
        child: Row(
          children: [
            Flexible(
              // 1 >>  give the image the min size to be appear we add with this the expanded widget to the column
              child: CircularStoreImage(
                isNetWorkImage: true,
                image:brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Expanded(
              //// 2 >>  give the image the min size to be appear we add with this the expanded widget to the column
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    BrandTitle_verifyIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    //  ** give the image the min size to be appear we add with this the expanded widget to the column>> this move to solve  long texts error
                    "${brand.productsCount ?? 0} products  ",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
