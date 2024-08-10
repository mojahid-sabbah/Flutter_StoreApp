import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appBar/appBar.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/features/shop/screens/AllProducts/Controller/allProductController.dart';
import 'package:t_store/features/shop/screens/AllProducts/Widget/SortableProducts.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage(
      {super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(allProductsController());

    return Scaffold(
      appBar: appBarWidget(
        showbackarrow: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: FutureBuilder(
                future: futureMethod ?? controller.fetchProductsByQuery(query),
                builder: (Context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const CircularProgressIndicator();
                  // }
                  // if (!snapshot.hasData ||
                  //     snapshot.data == null ||
                  //     snapshot.data!.isEmpty) {
                  //   return const Center(
                  //     child: Text("No data Found !*_*"),
                  //   );
                  // }

                  // if (snapshot.hasError) {
                  //   return const Center(
                  //     child: Text("sonething Went Wrong !*_*"),
                  //   );
                  // }
                  Widget loader = const CircularProgressIndicator();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);

                  if (widget != null) {
                    return widget;
                  }
                  final products = snapshot.data!;
                  return SortableProducts(
                    products: products,
                  );
                })),
      ),
    );
  }
}
