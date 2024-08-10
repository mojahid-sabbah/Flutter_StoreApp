import 'package:cloud_firestore/cloud_firestore.dart';

class categoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  categoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.isFeatured,
      this.parentId = ''});

// empty helper function
  static categoryModel empty() =>
      categoryModel(id: '', name: '', image: '', isFeatured: false);

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  // create a model from (get) firebase Document Snapshot .
  factory categoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return categoryModel(
          id: document.id,
          name: data['Name']??'',
          image: data['Image']??'',
          parentId: data['ParentId']??'',
          isFeatured: data['IsFeatured']?? false);
    } else {
      return categoryModel.empty();
    }
  }
}
