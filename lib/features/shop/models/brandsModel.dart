import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'productsCount': productsCount,
    };
  }

  // create a model from (get) firebase Document Snapshot .
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return BrandModel.empty();
    } else {
      return BrandModel(
          id: data['Id'] ?? '',
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          productsCount: data['productsCount'] ?? 0,
          isFeatured: data['IsFeatured'] ?? false);
    }
  }
  // create a model from (get) firebase Document Snapshot .
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          productsCount: data['productsCount'] ?? 0,
          isFeatured: data['IsFeatured'] ?? false);
    } else {
      return BrandModel.empty();
    }
  }
}
