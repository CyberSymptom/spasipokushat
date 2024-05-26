import 'package:get/get.dart';

import 'seller_quiz_form_controller.dart';

class SellerQuizFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerQuizFormController>(
      () => SellerQuizFormController(),
    );
  }
}
