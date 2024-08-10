import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();
  RxString selectedProductImage = ''.obs;

  List<String> getAllImages(ProductModel product) {
    Set<String> images = {};

    images.add(product.thumbnail);
    selectedProductImage.value = product.thumbnail;
    if (product.images != null) {
      images.addAll(product.images!);
    }
// get all productVariation images
    // if (product.productVariation != null ||
    //     product.productVariation!.isNotEmpty) {
    //   images.addAll(
    //       product.productVariation!.map((variation) => variation.image));
    // }

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.defaultSpace * 2,
                        horizontal: TSizes.defaultSpace),
                    child: Image(image: NetworkImage(image)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Align(
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text('close')),
                    ),
                  )
                ],
              ),
            ));
  }
}
