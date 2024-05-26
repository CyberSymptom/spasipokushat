import 'package:get/get.dart';

import 'seller_controller.dart';

class SellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerController>(
      () => SellerController(),
    );
  }
}
