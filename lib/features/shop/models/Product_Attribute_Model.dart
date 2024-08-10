class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'Name': name,
      'values': values,
    };
  }

  // create a model from (get) firebase Document Snapshot .
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return ProductAttributeModel();
    } else {
      return ProductAttributeModel(
        name: data.containsKey('Name') ? data['Name'] : '',
        values:
            data.containsKey('values') ? List<String>.from(data['values']) : [],

        // values:List<String>.from(data['values'])    ,
      );
    }
  }
}
