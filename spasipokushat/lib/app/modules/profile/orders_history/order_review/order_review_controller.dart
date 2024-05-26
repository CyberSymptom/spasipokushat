import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/widgets/loader.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';

class OrderReviewController extends GetxController {
  OrderReviewController(this.repository);

  final DbRepository repository;

  late FocusNode focusNode;
  late TextEditingController textController;

  final rate = 0.obs;
  final isFieldInFocus = false.obs;

  void setRate(int value) => rate.value = value;

  @override
  void onInit() {
    focusNode = FocusNode();
    textController = TextEditingController();
    listenForFieldFocusChanges();
    super.onInit();
  }

  @override
  void onClose() {
    focusNode.removeListener(() {
      isFieldInFocus.value = false;
    });
    focusNode.dispose();
    textController.dispose();
    super.onClose();
  }

  void listenForFieldFocusChanges() {
    focusNode.addListener(() {
      if (focusNode.hasPrimaryFocus) {
        isFieldInFocus.value = true;
      }
      if (!focusNode.hasPrimaryFocus) {
        isFieldInFocus.value = false;
      }
    });
  }

  void publishReview() async {
    final order = Get.arguments as OrderDto;
    final String sellerId = order.seller.sellerId;
    final String orderId = order.id!;
    debugPrint('$sellerId, $orderId');
    final review = ReviewDto(
      name: UserService.to.user.value!.name.isEmpty
          ? null
          : UserService.to.user.value!.name,
      review: textController.text.trim().isEmpty ? null : textController.text,
      rate: rate.value,
      order: orderId,
      seller: sellerId,
    );

    final publishedReview = await Get.showOverlay<ReviewDto?>(
      loadingWidget: const Loader(),
      asyncFunction: () async {
        final publishedReview = repository.publishReview(review);
        return publishedReview;
      },
    );

    if (publishedReview == null) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Произошла ошибка',
        duration: Duration(seconds: 2),
      ));
      return;
    }
    Get.back(result: true);
  }
}
