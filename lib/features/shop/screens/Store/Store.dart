import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/BrandCard/BrandCard.dart';
import 'package:t_store/common/widgets/LayoutsGrids/GridProductsLayout.dart';
import 'package:t_store/common/widgets/appBar/TabBarWidget.dart';
import 'package:t_store/common/widgets/containers/SearchContainer.dart';
import 'package:t_store/common/widgets/productsCart/CartCounterWidget.dart';
import 'package:t_store/common/widgets/texts/sectionHeading.dart';
import 'package:t_store/features/shop/controllers/categoriesController.dart';
import 'package:t_store/features/shop/screens/Brands/AllBrandsWidget.dart';
import 'package:t_store/features/shop/screens/Brands/BrandProducts.dart';
import 'package:t_store/features/shop/screens/Brands/controller/brandsController.dart';
import 'package:t_store/features/shop/screens/Store/Widgets/CategoriesTab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // call the list of categories >> featuredCategories[]
    final categories = categoriesController.instance.featuredCategories;
    final dark = THelperFunctions.isDarkMode(context);
    final brandController = Get.put(brandssController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CartCounterWidget(
                
                iconColor: dark ? TColors.white : TColors.black,
              ),
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrollrd) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? TColors.black : TColors.white,
                  expandedHeight: 400,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      //---------------------------------------------------------------------
                      children: [
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // search bar
                        const SearchContainer(
                          showborder: true,
                          padding: EdgeInsets.zero,
                          text: "Search in Store",
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        // Features Brands
                        sectionHeading(
                          textColor: dark ? TColors.white : TColors.dark,
                          title: "Features Brands",
                          onPressed: () => Get.to(() => const AllBrandsPage()),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        //-----   START         ****************************************--------------------
                        // Brands Grid

                        Obx(
                          () {
                            if (brandController.isLoading.value) {
                              return const CircularProgressIndicator();
                            }
                            if (brandController.featuredBrands.isEmpty) {
                              return Center(
                                  child: Text(
                                'No Data Found_!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ));
                            }

                            return GridProductsLayout(
                                itemCount:
                                    brandController.featuredBrands.length,
                                mainAxisExtent: 70,
                                ItemBuilder: (_, index) {
                                  final brand =
                                      brandController.featuredBrands[index];
              return BrandCard(  showBorder: true,     brand: brand,  onTap: () => Get.to(
                                        () => BrandProducts(brand: brand)),
                                  );
                                });
                          },
                        )

                        //*******      END       ******************************** */
                      ],
                    ),
                  ),
                  bottom: TabBarWidget(
                      tabs: categories
                          .map(
                            (item) => Tab(
                              child: Text(item.name),
                            ),
                          )
                          .toList()),
                )
              ];
            },
            body: 
            // TabBarView(
            //     children: categories
            //         .map(
            //           (category) => Tab(
            //             child: CategoriesTab(
            //               category: category,
            //             ),
            //           ),
            //         )
            //         .toList())
                      TabBarView(
                children: categories
                    .map(
                      (category) => CategoriesTab(
                        category: category,
                      ),
                    )
                    .toList())
                    
                    
                    ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////
