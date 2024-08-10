import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:t_store/features/authentication/screens/addCategories/fireStoreMethods.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class addCategories extends StatefulWidget {
  const addCategories({Key? key}) : super(key: key);

  @override
  State<addCategories> createState() => _addCategoriesState();
}

class _addCategoriesState extends State<addCategories> {
  // Declare variables
  File? imgPath;
  String? imgName;
  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final priceController = TextEditingController();

  // Enum for product categories

  Future<void> uploadImage2Screen(ImageSource imageSource) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: imageSource);

    try {
      if (pickedImage != null) {
        setState(() {
          imgPath = File(pickedImage.path);
          imgName = basename(pickedImage.path);
          int random = Random().nextInt(8);
          imgName = "$random$imgName";
        });
      } else {
        print("No Image Selected");
      }
    } catch (e) {
      print("Error >> $e");
    }
  }

  Uint8List? fileToUint8List(File? file) {
    if (file == null) return null;

    List<int> fileBytes = file.readAsBytesSync();
    return Uint8List.fromList(fileBytes);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      imgPath == null
                          ? const CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage(TImages.user),
                            )
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        bottom: -15,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  children: [
                                    SimpleDialogOption(
                                      onPressed: () {
                                        uploadImage2Screen(ImageSource.camera);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.camera_alt),
                                          SizedBox(width: 15),
                                          Text("Choose from Camera"),
                                        ],
                                      ),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        uploadImage2Screen(ImageSource.gallery);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.photo_library_outlined),
                                          SizedBox(width: 15),
                                          Text("Choose from gallery"),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            //  Navigator.pop(context);
                          },
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: firstnameController,
                          decoration: const InputDecoration(
                            labelText: " Category name",
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Use the custom dropdown for product categories

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });

                        // Convert imgPath to Uint8List
                        Uint8List? imgData = fileToUint8List(imgPath);

                        await fireStoreMethods().uploadProducts(
                          context: context,
                          imgName: imgName,
                          imgPath: imgData,
                          categoryName: firstnameController.text,
                          ProductsImgs: 'ProductsImgs',
                        );

                        setState(() {
                          isloading = false;
                          imgPath = null;
                          firstnameController.text = "";
                          priceController.text = "";
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15, top: 15),
                        child: const Text(
                          'Add Product',
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
