import 'package:get/get.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:spasipokushat/app/routes/home_routes.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class OrderDetailsController extends GetxController with StateMixin<OrderDto> {
  OrderDetailsController(this.repository);

  final DbRepository repository;
  @override
  void onInit() {
    fetchOrder();
    super.onInit();
  }

  void fetchOrder() async {
    final args = Get.arguments as OrderDto?;

    if (args != null) {
      change(args, status: RxStatus.success());
      return;
    }
    final order = await repository.fetchOrderById(Get.parameters['id']!);

    if (order == null) {
      change(args, status: RxStatus.error());
      return;
    }
    change(order, status: RxStatus.success());
  }

  void onMapCreated(YandexMapController ctr) {
    final point = state!.seller.point;
    ctr.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: 17,
        ),
      ),
      animation: const MapAnimation(duration: 0),
    );
  }

  void closePage() {
    if (Get.previousRoute.isEmpty) {
      Get.offAllNamed(HomeRoutes.home);
      return;
    }
    Get.back();
  }
}
