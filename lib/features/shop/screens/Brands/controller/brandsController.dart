import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/ProductsRepository.dart';
import 'package:t_store/data/repositories/brandsRepository.dart';
import 'package:t_store/features/shop/models/brandsModel.dart';
import 'package:t_store/features/shop/models/productsModel.dart';

class brandssController extends GetxController {
  static brandssController get instance => Get.find();
  RxBool isLoading = false.obs;
  RxList<BrandModel> allbrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandsRepository = Get.put(brandRepository());

  @override
  void onInit() {
    Fetchbrands();
    super.onInit();
  }

  Future<void> Fetchbrands() async {
    try {
      isLoading.value = true;
      // Fetch brands from data source (Firestore , api , etc....)
      final brands = await brandsRepository.getALLBrands();

      // update the brands list
      allbrands.assignAll(brands);

      //  flter featured category
      featuredBrands.assignAll(
          allbrands.where((brandss) => brandss.isFeatured ?? false).take(4));
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


// get brand for category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands = await brandsRepository
          .getbrandsforCategory(categoryId );
      return brands;
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
      return [];
    }
  }

// get brand specific products from data
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products = await productRepository.instance
          .getProductsforBrand(brandId: brandId , limit: limit);
      return products;
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
      return [];
    }
  }
}
