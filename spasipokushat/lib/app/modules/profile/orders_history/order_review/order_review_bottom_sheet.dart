import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';

import '../../../../core/theme/colors.dart';
import 'order_review_controller.dart';
import 'widgets/widgets.dart';

class OrderReviewBottomSheet extends StatelessWidget {
  const OrderReviewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderDto;
    return GetX(
      init: OrderReviewController(
        DbRepository(DbProvider()),
      ),
      builder: (controller) {
        return SizedBox(
          height: Get.height * 0.9,
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, 0, 22, bottomPadding),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: _buildDragHand(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: _buildHeading(order),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StarRating(),
                        ReviewField(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.isFieldInFocus.value,
                    child: const SubmitButton(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column _buildHeading(OrderDto order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Оцените заказ №${order.orderNumber}',
          style: GoogleFonts.ubuntu(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: headingColor,
            height: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'Поставьте оценку от 1 до 5',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: headingColor,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  Center _buildDragHand() {
    return Center(
      child: Container(
        width: 34,
        height: 4,
        decoration: BoxDecoration(
          color: onSurfaceSecondVariantColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  double get bottomPadding {
    double padding = 0;

    padding += Get.mediaQuery.viewPadding.bottom;

    if (padding == 0) {
      padding += 34;
      return padding;
    }
    return padding;
  }
}
