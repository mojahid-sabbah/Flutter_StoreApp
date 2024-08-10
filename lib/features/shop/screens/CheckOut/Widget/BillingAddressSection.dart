import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      sectionHeading(
        title: 'Shipping Address',
        buttonTitle: 'Change',
        onPressed: () {},
      ),
      const SizedBox(
        height: TSizes.spaceBtwItems / 2,
      ),
      Row(
        children: [
          const Icon(Icons.phone),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Text(
            '+97011321256',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
      const SizedBox(
        height: TSizes.spaceBtwItems / 2,
      ),



       Row(
        children: [
          const Icon(Icons.location_on),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Expanded(
            child: Text(
             'Palestine WestBank Tulkarem Qaffin lnknlknlknl',
             style: Theme.of(context).textTheme.bodyMedium,
              ),
          )
        ],
      ),
    ]);
  }
}
