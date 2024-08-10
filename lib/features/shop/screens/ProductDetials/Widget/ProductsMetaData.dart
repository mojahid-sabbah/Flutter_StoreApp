import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/BrandTitle_verifyIcon/BrandTitle_verifyIcon.dart';
import 'package:t_store/common/widgets/Images/CircularStoreImage.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/common/widgets/texts/cardProductsText.dart';
import 'package:t_store/common/widgets/texts/productPriceText.dart';
import 'package:t_store/features/shop/controllers/Product/productsController.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductsMetaData extends StatelessWidget {
  const ProductsMetaData({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = productsController.instance;
    final salePersentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircularContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                "$salePersentage%",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            //---------------------------
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),

            Text(
              '\$${product.price.roundToDouble()}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
              child: Text(' -- '),
            ),
              productPriceText(
              price:controller.getProductPrice(product).roundToDouble().toString(),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
          Row(
          children: [
            const cardProductsText(
              title: "Name  :",
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            cardProductsText(
              title:product.title,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        //---------------------------------------/

        Row(
          children: [
            const cardProductsText(
              title: "Status :",
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              controller.getStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

//----------------------------------------------

        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        Row(
          children: [
            CircularStoreImage(
              isNetWorkImage: true,
              image:product.brand != null ? product.brand!.image:'',
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.white : TColors.black, 
            ),
              BrandTitle_verifyIcon(
              title:product.brand !=null? product.brand!.name: '',
              brandTextSize: TextSizes.medium,
            )
          ],
        )
      ],
    );
  }
}
