import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String brandId;
  String categoryId;

  BrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });

  static BrandCategoryModel empty() => BrandCategoryModel(
        brandId: '',
        categoryId: '',
      );

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }

  factory BrandCategoryModel.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data.isEmpty) {
      return BrandCategoryModel.empty();
    } else {
      return BrandCategoryModel(
        brandId: data['brandId'] as String,
        categoryId: data['categoryId'] as String,
      );
    }
  }
}
