import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/enums/order_status_enum.dart';
import 'package:spasipokushat/app/data/extensions/datetime_extension.dart';
import 'package:spasipokushat/app/modules/profile/orders_history/orders_history_controller.dart';

class OrderCardWidget extends GetView<OrdersHistoryController> {
  final OrderDto order;
  const OrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openOrderDetailsPage(order),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [cardShadow],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderNumber(),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: _buildOrderCreationDate(),
                    ),
                  ],
                ),
                _buildOrderStatus(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildOrderItem(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildOrderPrice(),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: order.status == OrderStatusEnum.picked ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildReviewSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildOrderPrice() {
    return Text(
      '${order.price + order.serviceFee} руб.',
      style: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: onSurfaceColor,
        height: 0,
      ),
    );
  }

  Text _buildOrderItem() {
    return Text(
      order.item,
      style: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: onSurfaceColor,
        height: 0,
      ),
    );
  }

  Container _buildOrderStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9.5,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [cardShadow],
      ),
      child: Text(
        order.status.value,
        style: GoogleFonts.ubuntu(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: headingColor,
          height: 0,
        ),
      ),
    );
  }

  Text _buildOrderCreationDate() {
    return Text(
      order.createdAt!.toReadableFormat(),
      style: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: onSurfaceSecondVariantColor,
        height: 0,
      ),
    );
  }

  Text _buildOrderNumber() {
    return Text(
      'Заказ №${order.orderNumber}',
      style: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: headingColor,
        height: 0,
      ),
    );
  }

  Widget _buildReviewSection() {
    if (order.review == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.50,
                  color: onSurfaceSecondVariantColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.showReviewBottomSheet(order),
                borderRadius: BorderRadius.circular(5),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Оставить отзыв',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: headingColor,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(
              5,
              (index) => _buildStar(
                false,
                index < 4 ? false : true,
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            'Ваша оценка',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: headingColor,
              height: 0,
            ),
          ),
        ),
        Row(
          children: List.generate(
            5,
            (index) => _buildStar(
              index + 1 <= order.review!.rate ? true : false,
              index < 4 ? false : true,
            ),
          ),
        ),
      ],
    );
  }

  _buildStar(bool selected, bool last) {
    return Container(
      width: 18,
      height: 18,
      margin: last ? null : const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(1.5),
      child: SvgPicture.asset(
        selected ? 'assets/icons/star.svg' : 'assets/icons/star_unselected.svg',
      ),
    );
  }
}
