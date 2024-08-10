import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/models/Product_Attribute_Model.dart';
import 'package:t_store/features/shop/models/Product_Variation_Model.dart';
import 'package:t_store/features/shop/models/brandsModel.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariation;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.isFeatured,
    this.sku,
    this.date,
    this.salePrice = 0.0,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    this.productAttributes,
    this.productVariation,
  });

  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'Id': id ?? '',
      'IsFeatured': isFeatured ?? true,
      'Sku': sku ?? '',
      'Title': title ?? '',
      'Stock': stock ?? 0,
      'Price': price ?? 0.0,
      'images': images ?? [],
      'thumbnail': thumbnail ?? '',
      'SalePrice': salePrice ?? 0.0,
      'categoryId': categoryId ?? '',
      'brand': brand?.convert2Map(),
      'description': description ?? '',
      'productType': productType ?? '',
      'productAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.convert2Map()).toList()
          : [],
      'productVariation': productVariation != null
          ? productVariation!.map((e) => e.convert2Map()).toList()
          : [],
    };
  }

  // create a model from (get) firebase Document Snapshot .
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      print('FromSnap Shot ///////////////////**********');
      return ProductModel(
        id: document.id,
        sku: data['Sku'] ?? '',
        title: data['Title'] ?? '',
        stock: data['Stock'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        price: double.parse((data['Price'] ?? 0.0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        productType: data['productType'] ?? '',
        brand: BrandModel.fromJson(data['brand'] ?? {}),
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        productAttributes: (data['productAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList(), // list of map >> [map , map , ...]
        productVariation: (data['productVariation'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList(),
      );
    } else {
      return ProductModel.empty();
    }
  }

  // create a model from (get) firebase Document Snapshot .
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    if (document.data() != null) {
      
      print('FromSnap Shot ///////////////////**********');
      return ProductModel(
        id: document.id,
        sku: data['Sku'] ?? '',
        title: data['Title'] ?? '',
        stock: data['Stock'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        price: double.parse((data['Price'] ?? 0.0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        productType: data['productType'] ?? '',
        brand: BrandModel.fromJson(data['brand'] ?? {}),
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        productAttributes: (data['productAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList(), // list of map >> [map , map , ...]
        productVariation: (data['productVariation'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList(),
      );
    } else {
      return ProductModel.empty();
    }
  }
}
