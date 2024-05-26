import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        DbRepository(DbProvider()),
      ),
      fenix: true,
    );
  }
}
