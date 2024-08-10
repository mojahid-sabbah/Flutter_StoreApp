import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/features/shop/screens/ProductDetials/Widget/BottomAddtoCart.dart';
import 'package:t_store/features/shop/screens/ProductDetials/Widget/ProductAttrubutes.dart';
import 'package:t_store/features/shop/screens/ProductDetials/Widget/ProductsDetialsSlider.dart';
import 'package:t_store/features/shop/screens/ProductDetials/Widget/ProductsMetaData.dart';
import 'package:t_store/features/shop/screens/ProductDetials/Widget/RatingAndShare.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductDetials extends StatelessWidget {
  const ProductDetials({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image slider
            ProductsDetialsSlider(
              product: product,
            ),

            // products details
            Padding(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // rating and share
                  const RatingAndShare(),
                  // price , title stock brand
                  ProductsMetaData(
                    product: product,
                  ),
 ProductAttrubutes(product: product),
                  // product.productType == ProductType.variable.toString()
                  //     ? ProductAttrubutes(product: product)
                  //     : const SizedBox(
                  //         height: TSizes.spaceBtwSections,
                  //       ),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout')),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const sectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    // "Be Unique. Shop t-shirts sold by independent artists from around the globe. Buy the highest quality t-shirts on the internet. ,,Be Unique. Shop t-shirts sold by independent artists from around the globe. Buy the highest quality t-shirts on the internet.     ",

                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '  __(Show more)__',
                    trimExpandedText: '  ( less )',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  Row(
                    children: [
                      const sectionHeading(
                        title: 'Reviews  (75)',
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          )),
                    ],
                  ),
                  const BottomAddtoCart()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
