import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/BrandTitle_verifyIcon/BrandTitle_verifyIcon.dart';
import 'package:t_store/common/widgets/CircularIcon/CircularIcon.dart';
import 'package:t_store/common/widgets/Images/RoundedImage.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/common/widgets/productsCard/AddToCarticon.dart';
import 'package:t_store/common/widgets/texts/cardProductsText.dart';
import 'package:t_store/common/widgets/texts/productPriceText.dart';
import 'package:t_store/features/shop/controllers/Product/productsController.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/features/shop/screens/ProductDetials/ProductDetials.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class productCardVertical extends StatelessWidget {
  const productCardVertical({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = productsController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetials(
              product: product,
            ));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShadowStyle.VerticalproductCard],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            border: dark
                ? null
                : Border.all(color: const Color.fromARGB(255, 222, 221, 221)),
            color: dark ? TColors.darkerGrey : TColors.white),
        child: Column(
          children: [
            //card vertical image part
            CircularContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  // thumbnail image
                  Center(
                    child: RoundedImage(
                      // imageUrl: TImages.productImage1,
                      imageUrl: product.thumbnail,
                      applyImageUrlRadius: true,
                      isNetWorkImage: true,
                    ),
                  ),
                  // sale tag part
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: CircularContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          "$salePercentage%",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),
                  // favorite icon
                  const Positioned(
                      top: 1,
                      right: 1,
                      child: CircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 3,
            ),
            // text of card
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardProductsText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    BrandTitle_verifyIcon(
                      title: product.brand!.name,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ), // end of the main column
            ),

            const Spacer(), // it must be out of the main column

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                      if (product.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: Text(
                            product.price.toString(),
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: TSizes.sm),
                        child: productPriceText(
                          price:
                              // product.price.toString(),
                              controller
                                  .getProductPrice(product)
                                  .roundToDouble()
                                  .toString(),
                          isLarge: true,
                        ),
                      ),
                    ],
                  ),
                ),
            // ADD TO CART icon
              AddToCartIcon( product: product)
              ],
            )
          ],
        ),
      ),
    );
  }
}
