import 'package:get/get.dart';

import 'sellers_list_controller.dart';

class SellersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellersListController>(
      () => SellersListController(),
    );
  }
}
