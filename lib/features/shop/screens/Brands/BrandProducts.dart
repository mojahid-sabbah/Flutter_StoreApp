import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/BrandCard/BrandCard.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/models/brandsModel.dart';
import 'package:t_store/features/shop/screens/AllProducts/Widget/SortableProducts.dart';
import 'package:t_store/features/shop/screens/Brands/controller/brandsController.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = brandssController.instance;
    return Scaffold(
      appBar: appBarWidget(
        title: Text(
          brand.name,
          // style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              BrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    const loader = CircularProgressIndicator();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    final brandProducts = snapshot.data!;
                    return   SortableProducts(
                      products: brandProducts,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
