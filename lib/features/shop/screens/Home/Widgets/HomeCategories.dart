import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/VerticalImageText/VerticalImageText.dart';
import 'package:t_store/features/shop/controllers/categoriesController.dart';
import 'package:t_store/features/shop/screens/SubCategories/SubCategories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryController = Get.put(categoriesController());
    return Obx(
      () {
        if (CategoryController.isLoading.value) {
          return const CircularProgressIndicator();
        }

        if (CategoryController.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              'No data Found !!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        }
        return SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: CategoryController.featuredCategories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final categry = CategoryController.featuredCategories[index];

                return VerticalImageText(
                  image: categry.image,
                  title: categry.name,
                  onTap: () {
                    Get.to(() => const SubCategoriesPage());
                  },
                );
              }),
        );
      },
    );
  }
}
