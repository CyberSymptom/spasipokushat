import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

import 'orders_history_controller.dart';
import 'widgets/widgets.dart';

class OrdersHistoryPage extends GetView<OrdersHistoryController> {
  const OrdersHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: controller.obx(
        (orders) {
          return ListView.separated(
            padding: const EdgeInsets.all(22),
            itemBuilder: (context, index) {
              return OrderCardWidget(order: orders[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: orders!.length,
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: Get.back,
        icon: SvgPicture.asset(
          'assets/icons/left_arrow.svg',
          width: 18,
          height: 18,
        ),
      ),
      title: Text(
        'Заказы',
        style: GoogleFonts.ubuntu(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: headingColor,
          height: 0,
        ),
      ),
      centerTitle: true,
    );
  }
}
