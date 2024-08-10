import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/LayoutsGrids/GridProductsLayout.dart';
import 'package:t_store/common/widgets/productsCard/productCardVertical.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/shop/controllers/categoriesController.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/screens/AllProducts/AllProducts.dart';
import 'package:t_store/features/shop/screens/Store/Widgets/CategoryBrands.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({
    super.key,
    required this.category,
  });

  final categoryModel category;
  @override
  Widget build(BuildContext context) {
      final categoryController = categoriesController.instance;

    return ListView(
      // we add this listView to solve scroll proplems in thos widget
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [ 
              CategoryBrands(category: category),
              // BrandShowCase(dark: dark,images: const [
              //     TImages.productImage1,
              //     TImages.productImage2,
              //     TImages.productImage3],),
              FutureBuilder(
                  future: categoryController.getCategoryProducts(
                      categoryId: category.id),
                  builder: (context, snapshot) {
                    const loader = CircularProgressIndicator();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return Column(
                      children: [
                        sectionHeading(
                          title: "You Might like ",
                          onPressed: () => Get.to(AllProductsPage(
                            title: category.name,
                            futureMethod:
                                categoryController.getCategoryProducts(
                                    categoryId: category.id, limit: -1),
                          )),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        GridProductsLayout(
                            itemCount: products.length,
                            ItemBuilder: (_, index) => productCardVertical(
                                  product: products[index],
                                )),
                      ],
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
