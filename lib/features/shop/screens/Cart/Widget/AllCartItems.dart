import 'package:flutter/material.dart';
import 'package:t_store/features/shop/screens/Cart/Widget/CartItem.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllCartItems extends StatelessWidget {
  const AllCartItems({super.key, this.CheckOut = true});

  final bool CheckOut;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        shrinkWrap: true,
    // shrinkWrap: true,??    this line is very important or will return error (The following assertion was thrown during   performResize():// Vertical viewport was given unbounded heigh)
        itemCount: 2,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemBuilder: (_, index) =>   Column(
          children: [
            CartItem(showaddRemoveitem: CheckOut),
          ],
        ),
      ),
    );
  }
}
