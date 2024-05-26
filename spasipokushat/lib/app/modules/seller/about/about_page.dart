import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';
import 'package:spasipokushat/app/modules/seller/about/widgets/widgets.dart';

import 'about_controller.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SellerHeaderWidget(),
            SellerReviewsWidget(),
            SellerAddressWidget(),
            SellerContactsWidget(),
            SellerLocationWidget(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  GestureDetector _buildBottomNavBar() {
    return GestureDetector(
      onTap: controller.openSellerOnMap,
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.fromLTRB(22, 12, 22, 34),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Открыть в картах',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: onPrimaryColor,
            height: 0,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      leading: IconButton(
        onPressed: Get.back,
        icon: SvgPicture.asset(
          'assets/icons/arrow_back.svg',
        ),
      ),
      actions: [
        Obx(() {
          final homeC = Get.find<HomeController>();
          final bool isFavorite = homeC.isSellerFavorite(controller.seller);
          return GestureDetector(
            onTap: () {
              isFavorite
                  ? homeC.removeFromFavorite(controller.seller)
                  : homeC.addSellerToFavorite(controller.seller);
            },
            child: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                isFavorite
                    ? 'assets/icons/favorite_selected.svg'
                    : 'assets/icons/favorite_unselected.svg',
              ),
            ),
          );
        }),
        const SizedBox(width: 11)
      ],
    );
  }
}
