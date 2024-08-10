import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/CircularIcon/CircularIcon.dart';
 import 'package:t_store/features/shop/screens/Home/HomePage.dart';
import 'package:t_store/utils/constants/sizes.dart';

class wishListPage extends StatelessWidget {
  const wishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: Text(
            "WishList",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CircularIcon(icon: Iconsax.add , onPressed: () => Get.to(const HomePage()),)
          ],
        ),
        body: const SingleChildScrollView(
          child: 
          Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // GridProductsLayout(itemCount: 5, ItemBuilder: (_,index)=>const productCardVertical())
            ],
          ),),
        ),
    );
  }
}