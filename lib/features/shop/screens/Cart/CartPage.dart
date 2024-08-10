import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/screens/Cart/Widget/AllCartItems.dart';
import 'package:t_store/features/shop/screens/CheckOut/CheckOut.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        showbackarrow: true,
        title: Text(
          "My Cart",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: AllCartItems(),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {

          // Get.to(()=>const OrdersPage());

          Get.to(()=>const CheckOutPage());
        },
        child: const Text('Check Out   \$250.0'),
      ),
    );
  }
}
