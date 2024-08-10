import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class productRepository extends GetxController {
  static productRepository get instance => Get.find();

  // Variabels
  final FirebaseFirestore _DB = FirebaseFirestore.instance;
  //----------------------------------------------------------------------//

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _DB
          .collection("products")
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      //  print('t  222/////////////////////////////////////////');

      final list = snapshot.docs
          .map((decument) => ProductModel.fromSnapshot(decument))
          .toList();
      //  print('$list  222/////////////////////////////////////////');
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getFeaturedProducts_Something is Wrong @@! :  $e";
    }
  }

  Future<List<ProductModel>> getALLFeaturedProducts() async {
    try {
      final snapshot = await _DB
          .collection("products")
          .where('IsFeatured', isEqualTo: true)
          .get();
      //  print('t  222/////////////////////////////////////////');

      final list = snapshot.docs
          .map((decument) => ProductModel.fromSnapshot(decument))
          .toList();
      //  print('$list  222/////////////////////////////////////////');
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getALLFeaturedProducts_Something is Wrong @@! :  $e";
    }
  }

  Future<List<ProductModel>> getProductsByQuery(Query query) async {
    try {
      final querySnapShot = await query.get();
      final List<ProductModel> productList = querySnapShot.docs
          .map((decument) => ProductModel.fromQuerySnapshot(decument))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getFeaturedProducts_Something is Wrong @@! :  $e";
    }
  }

  Future<List<ProductModel>> getProductsforBrand(
      {required String brandId, int limit = -1}) async {
    try { // get products by brandslist link id brand fron product collection with
      final querySnapShot = limit == -1
          ? await _DB
              .collection('products')
              .where('brand.Id',
                  isEqualTo:
                      brandId) //'brand.Id'  --->>>>> field brand >> inner field >> Id
              .get()
          : await _DB
              .collection('products')
              .where('brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products = querySnapShot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getFeaturedProducts_Something is Wrong @@! :  $e";
    }
  }

  Future<List<ProductModel>> getProductsforcategory(
      {required String categoryId, int limit = -1}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _DB
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _DB
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productsIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      final productsQuery = await _DB
          .collection('products')
          .where(FieldPath.documentId, whereIn: productsIds)
          .get();
      final products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getFeaturedProducts_Something is Wrong @@! :  $e";
    }
  }
}
