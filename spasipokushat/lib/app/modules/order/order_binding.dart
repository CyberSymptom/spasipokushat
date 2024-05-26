import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';

import 'order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(DbRepository(DbProvider())),
    );
  }
}
