import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/CircularIcon/CircularIcon.dart';
import 'package:t_store/common/widgets/Images/RoundedImage.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/common/widgets/curvedEdges/ClipPathWidget.dart';
import 'package:t_store/features/shop/controllers/Product/ImagesController.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductsDetialsSlider extends StatelessWidget {
  const ProductsDetialsSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllImages(product);

    return ClipPathWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                        onTap: () {
                          controller.showEnlargedImage(image);
                        },
                        child: Image(image: NetworkImage(image)));
                  })),
                )),

// Image Slider

            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemBuilder: (_, index) => Obx(() {
                    final imageselected =
                        controller.selectedProductImage.value == images[index];
                    return RoundedImage(
                      onPressed: () {
                        controller.selectedProductImage.value = images[index];
                      },
                      width: 80,
                      isNetWorkImage: true,
                      imageUrl: images[index],
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      border: Border.all(
                          color:
                              imageselected ? TColors.primary : TColors.white),
                      padding: const EdgeInsets.all(TSizes.sm),
                    );
                  }),
                ),
              ),
            ),

            appBarWidget(showbackarrow: true, actions: [
              CircularIcon(
                icon: Iconsax.heart,
                color: dark ? TColors.white : TColors.dark,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
