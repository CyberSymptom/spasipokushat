import 'package:get/get.dart';

import 'app_version_controller.dart';

class AppVersionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppVersionController>(
      () => AppVersionController(),
    );
  }
}
