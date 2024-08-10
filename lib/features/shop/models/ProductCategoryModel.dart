import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String productId;
  String categoryId;

  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });

  static ProductCategoryModel empty() => ProductCategoryModel(
        productId: '',
        categoryId: '',
      );

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  factory ProductCategoryModel.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data.isEmpty) {
      return ProductCategoryModel.empty();
    } else {
      return ProductCategoryModel(
        productId: data['productId'] as String,
        categoryId: data['categoryId'] as String,
      );
    }
  }
}
