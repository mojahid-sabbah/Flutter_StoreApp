import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
 import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class CategoriesRepository extends GetxController {
  static CategoriesRepository get instance => Get.find();

  // Variabels
  //----------------------------------------------------------------------//
  final FirebaseFirestore _DB = FirebaseFirestore.instance;

  Future<List<categoryModel>> getAllCategories() async {
    try {
      final snapshot = await _DB.collection("Categories").get();
      print('/*---------------------------------------------------');
      final list = snapshot.docs
          .map((decument) => categoryModel.fromSnapshot(decument))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "CategoriesRepository_Something is Wrong @@! :  $e";
    }
  }
}
