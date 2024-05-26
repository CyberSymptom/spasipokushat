import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/seller/about/about_controller.dart';

class SellerHeaderWidget extends GetView<AboutController> {
  const SellerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 22, left: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLogoWidget(),
          _buildSellerName(),
        ],
      ),
    );
  }

  Text _buildSellerName() {
    return Text(
      controller.seller.name,
      style: GoogleFonts.ubuntu(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: headingColor,
        height: 0,
      ),
    );
  }

  Widget _buildLogoWidget() {
    if (controller.seller.logoUrl == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 51,
      height: 51,
      decoration: BoxDecoration(
        color: onSurfaceColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 8,
            offset: Offset(1, 1),
            spreadRadius: 0,
          )
        ],
        image: DecorationImage(
          isAntiAlias: true,
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            controller.seller.logoUrl!,
          ),
        ),
      ),
    );
  }
}
