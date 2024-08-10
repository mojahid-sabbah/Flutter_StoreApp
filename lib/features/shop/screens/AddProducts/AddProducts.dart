// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/features/authentication/screens/addCategories/fireStoreMethods.dart';

class addProducts extends StatefulWidget {
  const addProducts({Key? key}) : super(key: key);

  @override
  State<addProducts> createState() => _addProductsState();
}

class _addProductsState extends State<addProducts> {
  // Declare variables

  bool isloading = false;
  final _formKey = GlobalKey<FormState>();

  // Enum for product categories
//-------------------------

  // Define controllers for text fields
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _idController.dispose();
    _stockController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _titleController.dispose();
    _salePriceController.dispose();
    _descriptionController.dispose();
    _categoryIdController.dispose();
    _productTypeController.dispose();
    super.dispose();
  }

  List<XFile> imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();
  void selectedImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }

//-----------------------

  // Uint8List? fileToUint8List(File? file) {
  //   if (file == null) return null;

  //   List<int> fileBytes = file.readAsBytesSync();
  //   return Uint8List.fromList(fileBytes);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(60, 186, 248, 254),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: imageFileList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.file(
                              File(imageFileList[index].path),
                              fit: BoxFit.cover,
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      selectedImages();
                    },
                    child: const Text('Pick up your images'),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an ID';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 30), Add other
                  //TextFormField widgets for each attribute
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter stock';
                      }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   controller: _skuController,
                  //   decoration: const InputDecoration(labelText: 'SKU'),
                  // ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _salePriceController,
                    decoration: const InputDecoration(labelText: 'Sale Price'),
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _categoryIdController,
                    decoration: const InputDecoration(labelText: 'Category ID'),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _productTypeController,
                    decoration:
                        const InputDecoration(labelText: 'Product Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product type';
                      }
                      return null;
                    },
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
                        //  Uint8List? imgData = fileToUint8List(imgPath);

                        await fireStoreMethods().addProductToFirestore(
                          idController: _idController.text,
                          titleController: _titleController.text,
                          stockController: _stockController.text,
                          priceController: _priceController.text,
                          productTypeController: _productTypeController.text,
                          descriptionController: _descriptionController.text,
                          images: imageFileList,
                          salePriceController: _salePriceController.text,
                          categoryIdController: _categoryIdController.text,
                        );

                        setState(() {
                          isloading = false;
                          imageFileList = [];
                          _titleController.text = '';
                          _stockController.text = '';
                          _priceController.text = '';
                          _productTypeController.text = '';
                          _salePriceController.text = '';
                          _descriptionController.text = '';
                          _categoryIdController.text = '';
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
