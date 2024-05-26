import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/profile/orders_history/order_review/order_review_controller.dart';

class SubmitButton extends GetView<OrderReviewController> {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final rate = controller.rate.value;
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 700),
          crossFadeState: rate == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: const Color(0xFFCBCBCB),
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: Get.back,
                borderRadius: BorderRadius.circular(13),
                child: SizedBox.expand(
                  child: Center(
                    child: Text(
                      'Закрыть',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: onSurfaceColor,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          secondChild: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: controller.publishReview,
                borderRadius: BorderRadius.circular(13),
                child: SizedBox.expand(
                  child: Center(
                    child: Text(
                      'Продолжить',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: onPrimaryColor,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
