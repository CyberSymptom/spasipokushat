import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/core/widgets/loader.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/enums/order_status_enum.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'order_details_controller.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (order) => SizedBox(
          height: Get.height * 0.6,
          width: double.infinity,
          child: Stack(
            children: [
              YandexMap(
                mapObjects: [
                  PlacemarkMapObject(
                    mapId: MapObjectId(order!.id!),
                    point: order.seller.point,
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                          'assets/icons/user_pin.png',
                        ),
                        scale: 1.5,
                      ),
                    ),
                    text: PlacemarkText(
                      text: order.seller.pickupAddress,
                      style: const PlacemarkTextStyle(
                        color: headingColor,
                        size: 12,
                        offset: 4,
                        placement: TextStylePlacement.right,
                      ),
                    ),
                  )
                ],
                onMapCreated: controller.onMapCreated,
              ),
              Positioned(
                left: 16,
                top: Get.mediaQuery.viewPadding.top + 16,
                child: GestureDetector(
                  onTap: controller.closePage,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [cardShadow],
                    ),
                    padding: const EdgeInsets.all(8.5),
                    child: SvgPicture.asset(
                      'assets/icons/left_arrow.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onLoading: const Loader(),
      ),
      extendBody: true,
      bottomNavigationBar: controller.obx(
        (order) => Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: surfaceColor,
            boxShadow: const [cardShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: _buildDragHand(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(child: _buildOrderNumber(order!)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: _buildOrderStatus(order),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: _buildOrderDetailsCard(order),
              ),
              Visibility(
                visible: isPickupTimeVisible(order.status),
                child: Padding(
                  padding: const EdgeInsets.only(top: 34.0),
                  child: _buildPickUpTime(order),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isPickupTimeVisible(OrderStatusEnum status) {
    if (status == OrderStatusEnum.created || status == OrderStatusEnum.ready) {
      return true;
    } else {
      return false;
    }
  }

  Text _buildPickUpTime(OrderDto order) {
    return Text(
      'Заберите с ${order.seller.pickupTime[0]} '
      'до ${order.seller.pickupTime[1]}',
      style: GoogleFonts.ubuntu(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: headingColor,
        height: 0,
      ),
    );
  }

  Widget _buildOrderDetailsCard(OrderDto order) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.seller.name,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: headingColor,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.item,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff262626),
                    height: 0,
                  ),
                ),
                Text(
                  '${order.price}₽',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff262626),
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Сервисный сбор',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff262626),
                    height: 0,
                  ),
                ),
                Text(
                  '${order.serviceFee}₽',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff262626),
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffEAE9E8),
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Итого',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: headingColor,
                  height: 0,
                ),
              ),
              Text(
                '${order.price + order.serviceFee}₽',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: headingColor,
                  height: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildOrderStatus(OrderDto order) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [cardShadow],
          ),
          child: SvgPicture.asset('assets/icons/clock.svg'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            order.status.value,
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: headingColor,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  Text _buildOrderNumber(OrderDto order) {
    return Text(
      'Заказ №${order.orderNumber}',
      style: GoogleFonts.nunito(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: headingColor,
        height: 0,
      ),
    );
  }

  Container _buildDragHand() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: 34,
      height: 4,
      decoration: BoxDecoration(
        color: onSurfaceSecondVariantColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
