import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/Product/cart_Controller.dart';
import 'package:t_store/features/shop/screens/Cart/CartPage.dart';
import 'package:t_store/utils/constants/colors.dart';

class CartCounterWidget extends StatelessWidget {
  final Color iconColor;

  const CartCounterWidget({
    super.key,
    this.iconColor = TColors.white,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
            onPressed: () {Get.to(() => const CartPage());},
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Obx(
                 ()=> Text(
                    controller.noOfCartItem.value.toString(),
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: TColors.white,
                        ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
