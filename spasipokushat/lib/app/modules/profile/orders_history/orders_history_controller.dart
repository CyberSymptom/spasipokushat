import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/modules/profile/orders_history/order_review/order_review_bottom_sheet.dart';
import 'package:spasipokushat/app/routes/profile_routes.dart';

class OrdersHistoryController extends GetxController
    with StateMixin<List<OrderDto>> {
  OrdersHistoryController(this.repository);
  final DbRepository repository;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    change(null, status: RxStatus.loading());

    final orders = await repository.fetchUserOrders(
      UserService.to.user.value!.$id,
    );

    if (orders == null) {
      change(null, status: RxStatus.error());
      return;
    }
    if (orders.isEmpty) {
      change([], status: RxStatus.empty());
      return;
    }
    change(orders, status: RxStatus.success());
  }

  void showReviewBottomSheet(OrderDto order) async {
    final res = await Get.bottomSheet<bool>(
      const OrderReviewBottomSheet(),
      backgroundColor: surfaceColor,
      isScrollControlled: true,
      elevation: 0,
      settings: RouteSettings(
        name: ProfileRoutes.orderReview,
        arguments: order,
      ),
    );

    if (res != null && res == true) {
      fetchOrders();
      Get.showSnackbar(const GetSnackBar(
        message: 'Отзыв опубликован!',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void openOrderDetailsPage(OrderDto order) {
    Get.toNamed(
      ProfileRoutes.orderDetails,
      arguments: order,
      parameters: {'id': order.orderNumber},
    );
  }
}
