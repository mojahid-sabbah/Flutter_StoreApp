import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/LayoutsGrids/GridProductsLayout.dart';
import 'package:t_store/common/widgets/productsCard/productCardVertical.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/features/shop/screens/AllProducts/Controller/allProductController.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(allProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Obx(() {
          return GridProductsLayout(
              itemCount: controller.products.length,
              ItemBuilder: (_, index) => productCardVertical(
                    product: controller.products[index],
                  ));
        })
      ],
    );
  }
}
