import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/screens/Order/Widget/OrdersListItems.dart';
import 'package:t_store/utils/constants/sizes.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBarWidget(
        showbackarrow: true,
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: const Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      
      child: OrdersListItems(),),
    );
  }
}