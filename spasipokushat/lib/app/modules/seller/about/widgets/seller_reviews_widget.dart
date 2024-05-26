import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/seller/about/about_controller.dart';

class SellerReviewsWidget extends GetView<AboutController> {
  const SellerReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.seller.reviews.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22, top: 22),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/star.svg',
            colorFilter: const ColorFilter.mode(
              Color(0xffFFC107),
              BlendMode.srcIn,
            ),
            width: 15,
            height: 15,
          ),
          const SizedBox(width: 4),
          Text(
            '${controller.seller.rating} '
            '(${controller.seller.reviews.length})',
            style: GoogleFonts.ubuntu(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: headingColor,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
