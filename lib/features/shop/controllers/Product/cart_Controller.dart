 
import 'package:get/get.dart';
import 'package:t_store/common/widgets/SnackBar/TLoaders.dart';
import 'package:t_store/features/shop/controllers/Product/VariationController.dart';
import 'package:t_store/features/shop/models/cart_Item_Model.dart';
import 'package:t_store/features/shop/models/productsModel.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItem = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt ProQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  void addToCart(ProductModel product) {
    // quantity check
    if (ProQuantityInCart.value < 1) {
      TLoaders.warningSnackBar(message: 'Select Quantity', title: 'Oh Snap! ');
      return;
    }
    // check variation selected
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.warningSnackBar(message: 'Select variation', title: 'Oh Snap! ');
      return;
    }
// out of stock status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.warningSnackBar(
            message: 'Selected variation is Out of Stock', title: 'Oh Snap! ');
        return;
      } else {
        if (product.stock < 1) {
          TLoaders.warningSnackBar(
              message: 'Selected product is Out of Stock', title: 'Oh Snap! ');
          return;
        }
      }
      // convert  ProductModel to CartItemModel
      final selectedCartItem =
          convertToCartItem(product, ProQuantityInCart.value);

      int index = cartItems.indexWhere((cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId);
      if (index >= 0) {
        cartItems[index].quantity = selectedCartItem.quantity;
      } else {
        cartItems.add(selectedCartItem);
      }

      updateCart();
      TLoaders.successSnackBar(
          message: 'your product has been added to cart', title: 'Oh Snap! ');
    }
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity -= 1;
    } else {
      cartItems[index].quantity == 1
          ? removeFromCartDialog(index)
          : cartItems.removeAt(index);
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this Product ? ',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        TLoaders.successSnackBar(title: 'Product Removes From the Cart');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  CartItemModel convertToCartItem(ProductModel productt, int quantity) {
    if (productt.productType == ProductType.single.toString()) {
      variationController.resetselectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : productt.salePrice > 0.0
            ? productt.salePrice
            : productt.price;

    return CartItemModel(
        productId: productt.id,
        title: productt.title,
        price: price,
        quantity: quantity,
        variationId: variation.id,
        image: isVariation ? variation.image : productt.thumbnail,
        brandName: productt.brand != null ? productt.brand!.name : '',
        selectedVariation: isVariation ? variation.attributeValues : null);
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculaterTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculaterTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculaterTotalPrice;
    noOfCartItem.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemString = cartItems.map((item) => item.convert2Map()).toList();
    TLocalStorage.instance().writeData('cartItems', cartItemString);
  }

  void loadCartItems() {
    final cartItemsStrings =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemsStrings != null) {
      cartItems.assignAll(cartItemsStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId ) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final founfItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return founfItem.quantity;
  }

  void clearCart() {
    ProQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
