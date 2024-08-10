import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/screens/Cart/Widget/AllCartItems.dart';
import 'package:t_store/features/shop/screens/CheckOut/Widget/BillingAddressSection.dart';
import 'package:t_store/features/shop/screens/CheckOut/Widget/BillingPaymentSection.dart';
import 'package:t_store/features/shop/screens/CheckOut/Widget/AmountSection.dart';
import 'package:t_store/features/shop/screens/CheckOut/Widget/CouponCode.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/common/widgets/containers/CircularContainer.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        showbackarrow: true,
        title: Text(
          "Orders Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const AllCartItems(CheckOut: false),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              const CouponCode(),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              CircularContainer(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.white,
                child: const Column(
                  children: [
                    AmountSection(),
                    SizedBox( height: TSizes.spaceBtwItems,),
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems, ),
                    BillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems,),
                    BillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
   
   
   
   
    bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Get.to(()=>CheckOutPage());
        },
        child: const Text('Check Out   \$250.0'),
      ),
    );
  }
}
