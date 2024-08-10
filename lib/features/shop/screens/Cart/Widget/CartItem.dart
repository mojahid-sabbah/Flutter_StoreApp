import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/BrandTitle_verifyIcon/BrandTitle_verifyIcon.dart';
import 'package:t_store/common/widgets/Images/RoundedImage.dart';
import 'package:t_store/common/widgets/texts/cardProductsText.dart';
import 'package:t_store/common/widgets/texts/productPriceText.dart';
import 'package:t_store/features/shop/screens/Cart/Widget/ProductCountAddRemove.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,   required this.showaddRemoveitem ,
  });
  final bool showaddRemoveitem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedImage(
          imageUrl: TImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Expanded(
          // cardProductsText >> to make the overflow work expanded widget first step  __   1   __
          child: Column(
            mainAxisSize: MainAxisSize.min, //step  __   2   __
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandTitle_verifyIcon(title: 'Nike'),
              const Flexible(
                // step  __   3   __
                child: cardProductsText(
                  title: 'black Short Shoes ',
                  maxLines: 1,
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Color ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: ' Green ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: ' Size ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: ' UK 08',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ])),
              
              const SizedBox(height: TSizes.defaultSpace / 3,),
                Padding(
                padding: const EdgeInsets.only( right: TSizes.spaceBtwItems),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   
                   
                   
                   if(showaddRemoveitem) const ProductCountAddRemove(),
                    // SizedBox(width: TSizes.spaceBtwItems*4   ,),
                    const productPriceText(price: '250'),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
