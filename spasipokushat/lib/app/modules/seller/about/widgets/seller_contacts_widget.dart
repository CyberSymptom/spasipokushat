import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/seller/about/about_controller.dart';

class SellerContactsWidget extends GetView<AboutController> {
  const SellerContactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 34,
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
                _buildContactsLabel(),
                const SizedBox(height: 14),
                _buildPhoneNumber(),
                _buildWebSiteButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWebSiteButton() {
    if (controller.seller.website == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: GestureDetector(
        onTap: controller.openSellerOnMap,
        child: Text(
          'Сайт',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: primaryColor,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Text(
      controller.seller.phone,
      style: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: const Color(0xff252525),
        height: 0,
      ),
    );
  }

  Text _buildContactsLabel() {
    return Text(
      'Контакты',
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
      'assets/icons/phone.svg',
      width: 16,
      height: 20,
    );
  }
}
