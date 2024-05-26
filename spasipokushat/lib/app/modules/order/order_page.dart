import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

import 'order_controller.dart';
import 'widgets/widgets.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(22, 22, 22, bottomPadding),
        child: const Column(
          children: [
            SellerCardWidget(),
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            OrderDetailsCardWidget(),
            OrderTotalWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22, 12, 22, bottomPadding),
        child: _buildConfirmButton(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: Get.back,
        icon: SvgPicture.asset(
          'assets/icons/left_arrow.svg',
          width: 18,
          height: 18,
        ),
      ),
      title: Text(
        'Заказ',
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

  Widget _buildConfirmButton() {
    return Obx(() {
      return Skeletonizer(
        ignoreContainers: false,
        containersColor: const Color(0xffEAE9E8),
        enabled: controller.isFetching.value,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: controller.pay,
              child: Center(
                child: Text(
                  'Продолжить',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: onPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  double get bottomPadding {
    double padding = 0;
    padding += Get.mediaQuery.viewPadding.bottom;

    if (padding == 0) {
      padding += 22;
    }

    return padding += 12;
  }
}
