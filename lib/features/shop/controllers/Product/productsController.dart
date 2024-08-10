import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/ProductsRepository.dart';
import 'package:t_store/features/shop/models/productsModel.dart';

class productsController extends GetxController {
  static productsController get instance => Get.find();
  final productsRepository = Get.put(productRepository());
  final isLoading = false.obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    FetchProducts();
    super.onInit();
  }

  Future<void> FetchProducts() async {
    try {
      isLoading.value = true;
      // Fetch categories from data source (Firestore , api , etc....)
      final Products = await productsRepository.getFeaturedProducts();

      // update the Products list
      allProducts.assignAll(Products);

      //  flter featured category
      featuredProducts.assignAll(allProducts
          .where((productt) => productt.isFeatured == true)
          .take(4)
          .toList());
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> FetchALLProducts() async {
    try {
      // Fetch categories from data source (Firestore , api , etc....)
      final Products = await productsRepository.getALLFeaturedProducts();

      // update the Products list
      return Products;
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  double getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double percentage =
        ((product.price - product.salePrice) / product.price) * 100;
//                            170 / 220

    // double largestPrice = 0.0;
    if (product.salePrice > 0) {
      return (percentage / 100) * product.price;
    } else {
      return product.price;
    }
    // // if no variations return simple price or sale price
    // if (product.productType == ProductType.single.toString()) {
    //   return (product.salePrice > 0 ? product.salePrice : product.price)
    //       .toString();
    // } else {
    //   // for (var variation in product.productVariation!) {
    //   //   double priceToConsider =
    //   //       variation.salePrice > 0.0 ? variation.salePrice : variation.price;
    //   //   if (priceToConsider < smallestPrice) {
    //   //     smallestPrice = priceToConsider;
    //   //   }
    //   //   if (priceToConsider > smallestPrice) {
    //   //     largestPrice = priceToConsider;
    //   //   }
    //   // }

    //   // if smallestPrice == largestPrice retutn single price
    //   if (smallestPrice == largestPrice) {
    //     return largestPrice.toString();
    //   } else {
    //     return ' $smallestPrice - \$$largestPrice';
    //   }
    // }
  }

  String? calculateSalePercentage(double orginalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return null;
    }
    if (orginalPrice <= 0) {
      return null;
    }
    double percentage = ((orginalPrice - salePrice) / orginalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
