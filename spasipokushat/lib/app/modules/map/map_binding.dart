import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';

import 'map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(DbRepository(DbProvider())),
    );
  }
}
