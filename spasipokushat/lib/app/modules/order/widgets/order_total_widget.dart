import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/modules/order/order_controller.dart';

class OrderTotalWidget extends GetView<OrderController> {
  const OrderTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Get.arguments as SellerDto;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Итог',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: headingColor,
                height: 0,
              ),
            ),
            Skeletonizer(
              enabled: controller.isFetching.value,
              effect: const ShimmerEffect(
                baseColor: Color(0xffD5D5D5),
              ),
              child: Text(
                '${seller.finalPrice + controller.serviceFee.value}₽',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: headingColor,
                  height: 0,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
