import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/brandsModel.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class brandRepository extends GetxController {
  static brandRepository get instance => Get.find();

  final FirebaseFirestore _DB = FirebaseFirestore.instance;

  Future<List<BrandModel>> getALLBrands() async {
    try {
      final snapshot = await _DB.collection("brands").get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
      print('getALLBrands //*------------------------------');
      return list; 
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getALLBrands_Something is Wrong @@! :  $e";
    }
  } 

  Future<List<BrandModel>> getbrandsforCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _DB
          .collection("BrandCategory")
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      final brandsQuery = await _DB
          .collection("brands")
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "getALLBrands_Something is Wrong @@! :  $e";
    }
  }
}
