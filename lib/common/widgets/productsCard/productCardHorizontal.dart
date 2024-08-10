import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/BrandTitle_verifyIcon/BrandTitle_verifyIcon.dart';
import 'package:t_store/common/widgets/CircularIcon/CircularIcon.dart';
import 'package:t_store/common/widgets/Images/RoundedImage.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/common/widgets/texts/cardProductsText.dart';
import 'package:t_store/common/widgets/texts/productPriceText.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class productCardHorizontal extends StatelessWidget {
  const productCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShadowStyle.VerticalproductCard],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            border: dark
                ? null
                : Border.all(color: const Color.fromARGB(255, 222, 221, 221)),
            color: dark ? TColors.darkerGrey : TColors.white),
        child: Row(
          children: [
            CircularContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  const RoundedImage(
                    imageUrl: TImages.productImage1,
                    applyImageUrlRadius: true,
                  ),

                  Positioned(
                    top: 12,
                    child: CircularContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        "25%",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),
                  // favorite icon
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: CircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
         
         
         
             SizedBox(
            width: 190,
             child: Padding(
padding: const EdgeInsets.only(left: TSizes.sm , top:  TSizes.sm*1.5),    
           child: Column(
                 children: [
                     const Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         cardProductsText(  title: "Green Nike Air Green Nike Air sdvsvs",   smallSize: true,  ),
                         SizedBox(  height: TSizes.spaceBtwItems / 2,  ),
                         BrandTitle_verifyIcon(  title: 'Nike',  ),
                       ],
                     ),
                const Spacer(),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(child: Padding(
                    padding: EdgeInsets.only(left: TSizes.sm),
                    child: productPriceText(  price: '53',  isLarge: true,  ),
                  )),
                  Container(
                    decoration: BoxDecoration(
                        color: dark ? TColors.white : TColors.dark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight: Radius.circular(TSizes.productImageRadius),
                        )),
                    child: SizedBox(  width: TSizes.iconLg * 1.2,  height: TSizes.iconLg * 1.2,
                    child: Center(  child: Icon(  Icons.add,  color: dark ? TColors.dark : TColors.white,   ))),
                  )
                ],
                         )
                
                
                
                
                 ],
               ),
             ),
           ),


           
            
          ],
        ));
  }
}
