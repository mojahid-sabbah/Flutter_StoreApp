import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/common/widgets/texts/cardProductsText.dart';
import 'package:t_store/common/widgets/texts/productPriceText.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/shop/controllers/Product/VariationController.dart';
import 'package:t_store/features/shop/controllers/Product/productsController.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/features/shop/screens/ProductDetials/Widget/ChoiceChipWidget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductAttrubutes extends StatelessWidget {
  const ProductAttrubutes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = productsController.instance;
    final variationVontrollerr = Get.put(VariationController());
    return Obx(
      ()=> Column(
        children: [
          if (variationVontrollerr.selectedVariation.value.id.isNotEmpty)
            CircularContainer(
                radius: TSizes.md,
                backgroundColor: dark
                    ? TColors.darkGrey.withOpacity(0.8)
                    : TColors.grey.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm, vertical: TSizes.xs),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const sectionHeading(
                          title: "Varition",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const cardProductsText(
                                  title: "Price  :",
                                ),
                                const SizedBox(
                                  width: TSizes.sm,
                                ),
                              if(variationVontrollerr.selectedVariation.value.price >0)
                                Text(
                                  '\$${variationVontrollerr.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                  productPriceText(
                                  price: variationVontrollerr.getVariationPrice(),
                                ),
                              ],
                            ),
                            //--------------------
    
                            Row(
                              children: [
                                const cardProductsText(
                                  title: "Status :",
                                ),
                                const SizedBox(
                                  width: TSizes.sm,
                                ),
                                Text(
                                  variationVontrollerr.variationStockStatus.value,
                                  // controller.getStockStatus(product.stock),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                      cardProductsText(
                      title: variationVontrollerr.selectedVariation.value.description??'',
                          // "This is the Description of the Product and it can go up to max 4 lines ... ",
                      smallSize: true,
                      maxLines: 4,
                    ),
                  ],
                )),
    
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
    
          // product Attributes >> Colors and Sizes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionHeading(
                    title: attribute.name ?? '',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Obx(
                    ()=> Wrap(
                      spacing: 8,
                      children: attribute.values!.map((attributeValue) {
                        final isSelected = variationVontrollerr
                                .selectedAttributes[attribute.name] ==
                            attributeValue;
                  
                        final available = variationVontrollerr
                            .getAttributesAvailabilityInVariation(
                                product.productVariation!, attribute.name!)
                            .contains(attributeValue);
                        return ChoiceChipWidget(
                          text: attributeValue,
                          selected: isSelected,
                          onSelected: available
                              ? (selected) {
                                  if (selected && available) {
                                    variationVontrollerr.onAttributeSelected(
                                        product,
                                        attribute.name ?? '',
                                        attributeValue);
                                  }
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
