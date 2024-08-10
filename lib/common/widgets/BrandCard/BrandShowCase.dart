import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/BrandCard/BrandCard.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/features/shop/models/brandsModel.dart';
import 'package:t_store/features/shop/screens/Brands/BrandProducts.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key,
    required this.dark,
    required this.images,
    required this.brand,
  });

  final bool dark;
  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: CircularContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            BrandCard(
              showBorder: false,
              brand: brand,
            ),
            Row(
                children: images
                    .map((image) => brandTopProductImagesWidget(dark, image))
                    .toList()),
          ],
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------------//
Widget brandTopProductImagesWidget(bool dark, String image) {
  return Expanded(
    child: CircularContainer(
        height: 100,
        backgroundColor: dark ? TColors.darkGrey : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        child: Image(
          image: NetworkImage(image)
          )),
  );
}
