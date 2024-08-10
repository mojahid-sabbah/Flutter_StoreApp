
class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel(
      {required this.productId,
      required this.quantity,
      this.variationId = '',
      this.image,
      this.price = 0.0,
      this.title = '',
      this.brandName,
      this.selectedVariation});

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  //                 tojson
  Map<String, dynamic> convert2Map() {
    return {
      'productId': productId,
      'title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      'variationId': variationId,
      'BrandName': brandName,
      'SelectedVariation': selectedVariation,
    };
  }

  // create a model from (get) firebase Document Snapshot .
  factory CartItemModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return CartItemModel.empty();
    } else {
      return CartItemModel(
          productId: data['productId'],
          title: data['title'] ?? '',
          image: data['Image'] ?? '',
          quantity: data['quantity'] ?? 0,
          price: data['Price']?.toDouble(),
          variationId: data['variationId'],
          brandName: data['BrandName'],
          selectedVariation: data['SelectedVariation'] != null
              ? Map<String, String>.from(data['SelectedVariation'])
              : null);
    }
  }
}
