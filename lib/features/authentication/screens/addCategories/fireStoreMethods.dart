import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:t_store/common/widgets/SnackBar/SnackBar.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:uuid/uuid.dart';

class fireStoreMethods {
  uploadProducts({
    required context,
    required String? imgName,
    required Uint8List? imgPath,
    required String categoryName,
    required String ProductsImgs,
  }) async {
    try {
      String imgUrl = '';

      if (imgPath != null) {
        final storageRef = FirebaseStorage.instance.ref(
            "${FirebaseAuth.instance.currentUser!.uid}/$ProductsImgs/$imgName ");
        // await storageRef.putFile(imgPath);
        //----------   we use down code instedof up in web  ----------/
        UploadTask uploadtask = storageRef.putData(imgPath);
        TaskSnapshot snap = await uploadtask;
        //-------------------/

        imgUrl = await snap.ref.getDownloadURL();
      }

      var id4 = const Uuid().v4();

      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Reference the "ProductsCollection" within the user's document
      CollectionReference userProductsCollection =
          FirebaseFirestore.instance.collection("Categories");

      categoryModel productsFields = categoryModel(
          id: id4, name: categoryName, image: imgUrl, isFeatured: true);

      // Add the product to the "ProductsCollection"
      await userProductsCollection.add(productsFields.convert2Map());

      ShowSnackBar(context, "Product Added succesfully", 0xFF49B369);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowSnackBar(context, "The password provided is too weak", 0xFFF4CC52);
      } else if (e.code == 'email-already-in-use') {
        ShowSnackBar(
            context, "The account already exists for that email", 0xFFF4CC52);
      } else if (e.code == 'invalid-email') {
        ShowSnackBar(context, "ERROR, Invalid Email @_@!", 0xFFF4CC52);
      } else {
        ShowSnackBar(context, "ERROR, please try again *_*!", 0xFFF4CC52);
      }
    } catch (e) {
      ShowSnackBar(context, e.toString(), 0xFFF4CC52);
    }
  }

  addProductToFirestore({
    required List<XFile> images,
    required String idController,
    required String titleController,
    required String stockController,
    required String priceController,
    required String productTypeController,
    required String salePriceController,
    required String descriptionController,
    required String categoryIdController,
  }) async {
    try {
    // Reference to the Firebase Storage bucket
    final storageRef =  FirebaseStorage.instance.ref();

    List<String> uploadedImageUrls = [];

    // Upload images to Firebase Storage
    for (int i = 0; i < images.length; i++) {
      File imageFile = File(images[i].path);
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_image_$i';
      // Upload the image file to Firebase Storage
      print('Image  ly! ---------------------------------------');
     
      await storageRef.child('ProductsImages/$fileName').putFile(imageFile);
      String downloadUrl = await storageRef.child('ProductsImages/$fileName').getDownloadURL();
      uploadedImageUrls.add(downloadUrl);
      print('Image $i uploaded successfully! ---------------------------------------');
    }

    // Create a ProductModel instance
    ProductModel product = ProductModel(
      id: idController, // Generate or assign an ID for the product
      title: titleController,
      stock: int.parse(stockController),
      price: double.parse(priceController),
      thumbnail: uploadedImageUrls.isNotEmpty ? uploadedImageUrls[0] : '',
      productType: productTypeController,
      description: descriptionController,
      images: uploadedImageUrls,
      salePrice: double.parse(salePriceController),
      categoryId: categoryIdController,
    );

    // Add the product to Firestore
    CollectionReference productsCollection = FirebaseFirestore.instance.collection("products");
    await productsCollection.add(product.convert2Map());

    // Show success message
    TLoaders.successSnackBar(
      title: 'Congratulations',
      message: 'Your product has been created successfully!',
    );
  } catch (e) {
      print(e.toString());
      TLoaders.errorSnackBar(title: 'catch Error :', message: e.toString());
    }
  }
}
