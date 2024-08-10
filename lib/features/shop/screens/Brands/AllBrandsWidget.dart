import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/BrandCard/BrandCard.dart';
import 'package:t_store/common/widgets/LayoutsGrids/GridProductsLayout.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/shop/screens/Brands/BrandProducts.dart';
import 'package:t_store/features/shop/screens/Brands/controller/brandsController.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = brandssController.instance;
    return Scaffold(
      appBar: appBarWidget(
        showbackarrow: true,
        title: Text(
          "Brands Products",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const sectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                () {
                  if (brandController.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  if (brandController.allbrands.isEmpty) {
                    return Center(
                        child: Text(
                      'No Data Found!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ));
                  }

                  return GridProductsLayout(
                      itemCount: brandController.allbrands.length,
                      mainAxisExtent: 70,
                      ItemBuilder: (_, index) {
                        final brand = brandController.allbrands[index];
                        return BrandCard(
                          showBorder: true,
                          brand: brand,
                          onTap: ()=> Get.to(()=> BrandProducts(brand: brand,)),
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
