import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/profile/orders_history/order_review/order_review_controller.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<OrderReviewController>(
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: controller.rate.value > 0,
              child: Text(
                '${controller.rate.value}',
                style: GoogleFonts.nunito(
                  fontSize: 56,
                  fontWeight: FontWeight.w400,
                  color: headingColor,
                  height: 0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => _buildStar(
                    onTap: () => controller.setRate(index + 1),
                    index: index + 1,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildStar({
    required void Function()? onTap,
    required int index,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Obx(() {
          final rate = Get.find<OrderReviewController>().rate.value;
          if (rate < index) {
            return SvgPicture.asset(
              'assets/icons/star_unselected.svg',
            );
          }
          return SvgPicture.asset(
            'assets/icons/star.svg',
          );
        }),
      ),
    );
  }
}
