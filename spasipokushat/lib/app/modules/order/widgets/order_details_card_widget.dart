import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/modules/order/order_controller.dart';

class OrderDetailsCardWidget extends GetView<OrderController> {
  const OrderDetailsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Get.arguments as SellerDto;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [cardShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProductPrice(seller),
          Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: _buildServiceFee(),
          ),
        ],
      ),
    );
  }

  Row _buildServiceFee() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Сервисный сбор',
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: onSurfaceColor,
            height: 0,
          ),
        ),
        Obx(() {
          return Skeletonizer(
            effect: const ShimmerEffect(
              baseColor: Color(0xffD5D5D5),
            ),
            enabled: controller.isFetching.value,
            child: Text(
              '${controller.serviceFee.value}₽',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: headingColor,
                height: 0,
              ),
            ),
          );
        }),
      ],
    );
  }

  Row _buildProductPrice(SellerDto seller) {
    final textStyle = GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: headingColor,
      height: 0,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          seller.productName,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: onSurfaceColor,
            height: 0,
          ),
        ),
        Builder(
          builder: (context) {
            if (seller.salePrice != null) {
              return Text(
                '${seller.salePrice}₽',
                style: textStyle,
              );
            }
            return Text(
              '${seller.regularPrice}₽',
              style: textStyle,
            );
          },
        ),
      ],
    );
  }
}
