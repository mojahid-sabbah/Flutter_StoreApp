import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionHeading(title: 'Payment Method' , buttonTitle: 'Change', onPressed: (){}
        ,),
          const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),

              Row(
                children: [
                  CircularContainer(
                    width: 60,
                    height: 35,
                    backgroundColor:THelperFunctions.isDarkMode(context) ? TColors.light : TColors.white,
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: const Image(image: AssetImage(TImages.paypal) , fit: BoxFit.contain,),
                  ),
                    const SizedBox(
                width: TSizes.spaceBtwItems/2,
              ),
              const Text('PayPal')
                ],
              )
      ],
    );
  }
}