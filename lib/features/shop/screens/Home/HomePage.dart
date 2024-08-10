import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/LayoutsGrids/GridProductsLayout.dart';
import 'package:t_store/common/widgets/containers/SearchContainer.dart';
import 'package:t_store/common/widgets/productsCard/productCardVertical.dart';
import 'package:t_store/common/widgets/productsCart/CartCounterWidget.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/shop/controllers/Product/productsController.dart';
import 'package:t_store/features/shop/screens/AllProducts/AllProducts.dart';
import 'package:t_store/features/shop/screens/Home/Widgets/HomeAppBar.dart';
import 'package:t_store/common/widgets/containers/PrimaryHeaderContainer.dart';
import 'package:t_store/features/shop/screens/Home/Widgets/HomeCategories.dart';
import 'package:t_store/features/shop/screens/Home/Widgets/PromoSlider.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(productsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  // app bar have 2 title +  cart counter icon
                  const HomeAppBar(
                    Actions: [
                      // this icon Counter cart in app bar
                      CartCounterWidget(
                      
                      ),
                    ],
                  ),
                  //  search bar
                  const SearchContainer(
                    text: "Search in Store",
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        sectionHeading(
                          textColor: TColors.white,
                          title: "popular Categories",
                          showActionButton: false,
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        //  ListView.builder >> Categories Icons ROW ------------------
                        const HomeCategories()
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            //---------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              // slide bar widget just add the imgs url
              child: Column(
                children: [
                  const PromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sectionHeading(
                        textColor: TColors.dark,
                        title: "popular Products",
                        showActionButton: false,
                        onPressed: () {},
                      ),
                      TextButton(
                          onPressed: () => Get.to(() => AllProductsPage(
                                title: 'popular Products',
                                // query: FirebaseFirestore.instance
                                //     .collection('products')
                                //     .where('IsFeatured', isEqualTo: true)
                                //     .limit(6),
                                    futureMethod: controller.FetchALLProducts(),
                              )),
                          child: Text(
                            "View All",
                            style: Theme.of(context).textTheme.labelLarge,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 3,
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const CircularProgressIndicator();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return const Center(
                        child: Text('No data Found'),
                      );
                    }

                    return GridProductsLayout(
                        itemCount: controller.featuredProducts.length,
                        ItemBuilder: (_, index) => productCardVertical(
                              product: controller.featuredProducts[index],
                            ));
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
