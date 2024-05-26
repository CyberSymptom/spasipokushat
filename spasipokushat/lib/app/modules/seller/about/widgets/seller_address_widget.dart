import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/seller/about/about_controller.dart';

class SellerAddressWidget extends GetView<AboutController> {
  const SellerAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 44,
        right: 22,
        left: 22,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddressLabel(),
                const SizedBox(height: 14),
                _buildPickupAddress(),
                const SizedBox(height: 14),
                _buildTextButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _buildTextButton() {
    return GestureDetector(
      onTap: controller.openSellerOnMap,
      child: Text(
        'Маршрут',
        style: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          decoration: TextDecoration.underline,
          decorationColor: primaryColor,
          height: 0,
        ),
      ),
    );
  }

  Widget _buildPickupAddress() {
    return Text(
      controller.seller.pickupAddress,
      style: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: const Color(0xff252525),
        height: 0,
      ),
    );
  }

  Text _buildAddressLabel() {
    return Text(
      'Адрес',
      style: GoogleFonts.ubuntu(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: const Color(0xff252525),
        height: 0,
      ),
    );
  }

  SvgPicture _buildIcon() {
    return SvgPicture.asset(
      'assets/icons/location.svg',
      width: 16,
      height: 20,
    );
  }
}
