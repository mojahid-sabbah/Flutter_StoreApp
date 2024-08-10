
class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'Id': id,
      'Image': image,
      'description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Sku': sku,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  // create a model from (get) firebase Document Snapshot .
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return ProductVariationModel.empty();
    } else {
      return ProductVariationModel(
        id: data['Id'] ?? '',
        price: double.parse((data['Price'] ?? 0.0).toString()),
        sku: data['Sku'] ?? '',
        stock: data['Stock'] ?? 0,
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        image: data['Image'] ?? '',
        attributeValues: Map<String, String>.from(data['AttributeValues']),
      );
    }
  }
}
