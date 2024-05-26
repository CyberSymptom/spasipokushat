import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';

import 'orders_history_controller.dart';

class OrdersHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersHistoryController>(
      () => OrdersHistoryController(DbRepository(DbProvider())),
    );
  }
}
