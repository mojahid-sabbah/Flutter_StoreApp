import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/data/repositories/authentication_repositry.dart';
import 'package:t_store/features/personalization/models/userModel.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class UserRepositry extends GetxController {
  static UserRepositry get instance => Get.find();
// Variabels
  //----------------------------------------------------------------------//
  final FirebaseFirestore _DB = FirebaseFirestore.instance;

  Future<void> saveUserRecored(UserModel user) async {
    try {
      //                                              . tojson
      await _DB.collection("Users").doc(user.id).set(user.convert2Map());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something is Wrong @@! :  $e";
    }
  }

  // function to fetch(get or read) user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      //  it get the current user id V     >>>  .doc(AuthenticationRepositry.instance.authUser?.uid)
      final documentSnapShot = await _DB
          .collection('Users')
          .doc(AuthenticationRepositry.instance.authUser?.uid)
          .get();
      if (documentSnapShot.exists) {
        return UserModel.fromSnapshot(documentSnapShot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something is Wrong @@! :  $e";
    }
  }

// update all User Details
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      //                                              . tojson
      await _DB
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.convert2Map());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something is Wrong @@! :  $e";
    }
  }

// update User Field
  Future<void> updateUserField(Map<String, dynamic> json) async {
    try {
      await _DB
          .collection("Users")
          .doc(AuthenticationRepositry.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something is Wrong @@! :  $e";
    }
  }

// remove User Record
  Future<void> removeUserRecord(String userId) async {
    try {
      await _DB.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something is Wrong @@! :  $e";
    }
  }
// upload any image 
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something is Wrong @@! :  $e";
    }
  }
}
