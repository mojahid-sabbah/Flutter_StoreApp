import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/data/repositories/CategoriesRepository/CategoriesRepository.dart';
import 'package:t_store/data/repositories/ProductsRepository.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/models/productsModel.dart';

class categoriesController extends GetxController {
  static categoriesController get instance => Get.find();
  final categoriesRepository = Get.put(CategoriesRepository());
  final isLoading = false.obs;
  RxList<categoryModel> allCategories = <categoryModel>[].obs;
  RxList<categoryModel> featuredCategories = <categoryModel>[].obs;

  @override
  void onInit() {
    FetchCategories();
    super.onInit();
  }

  Future<void> FetchCategories() async {
    try {
      isLoading.value = true;
      // Fetch categories from data source (Firestore , api , etc....)
      final categories = await categoriesRepository.getAllCategories();

      // update the categories list
      allCategories.assignAll(categories);

      // flter featured category
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'FetchCategories catch Error :', message: e.toString());
    } finally {
      isLoading.value = false;
    } 
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = -1}) async {
    try {
      final products = await productRepository.instance
          .getProductsforcategory(categoryId: categoryId , limit: limit);
      return products;
    } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
      return [];
    }
  }
}
