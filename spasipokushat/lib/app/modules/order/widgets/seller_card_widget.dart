import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/modules/order/order_controller.dart';

class SellerCardWidget extends GetView<OrderController> {
  const SellerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Get.arguments as SellerDto;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSellerThumbnail(seller),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _buildCardHeading(seller),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: _buildSellerPickupAddress(seller),
          ),
        ],
      ),
    );
  }

  Row _buildSellerPickupAddress(SellerDto seller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/location.svg',
          width: 24,
          height: 24,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              seller.pickupAddress,
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: headingColor,
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text _buildCardHeading(SellerDto seller) {
    return Text(
      seller.name,
      style: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: headingColor,
        height: 0,
      ),
    );
  }

  AspectRatio _buildSellerThumbnail(SellerDto seller) {
    return AspectRatio(
      aspectRatio: 16 / 6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: seller.thumbnailUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
