import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/BrandCard/BrandShowCase.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/screens/Brands/controller/brandsController.dart';
 import 'package:t_store/utils/helpers/cloud_helper_functions.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final categoryModel category;
  // category came from >>   CategoryBrands(category: category),
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = brandssController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          const loader = CircularProgressIndicator();
          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final brands = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
             
             
                final brand = brands[index];
                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandId: brand.id, limit: 3),
                    builder: (context, snapshot) {
                      const loader = CircularProgressIndicator();
                      final widget = TCloudHelperFunctions.checkMultiRecordState(
                                      snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                  
                      return BrandShowCase(
                        dark: dark,
                        brand: brand,
                        images: products.map((e) => e.thumbnail).toList(),
                      );
                    });
              });
        });
  }
}
