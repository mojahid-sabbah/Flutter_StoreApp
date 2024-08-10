import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/Product/VariationController.dart';
import 'package:t_store/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
