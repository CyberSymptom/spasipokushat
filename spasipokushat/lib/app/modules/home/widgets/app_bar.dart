
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';

import '../../../routes/user_address_routes.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Get.mediaQuery.viewPadding.top,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(UserAddressRoutes.userAddress);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Мой адрес',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.36,
                    color: onSurfaceColor,
                  ),
                ),
                const SizedBox(width: 6),
                SvgPicture.asset(
                  'assets/icons/down_arrow.svg',
                  width: 10,
                  fit: BoxFit.cover,
                  semanticsLabel: 'down arrow',
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          GetX<UserService>(
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(UserAddressRoutes.userAddress);
                },
                child: Text(
                  controller.userAddress.isNotEmpty
                      ? controller.userAddress.value
                      : 'Введите ваш адрес',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.36,
                    color: const Color(0xff20201F),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Get.find<HomeController>().showRadiusSelectionBottomSheet();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                6.0,
                6,
                6,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/near_me.svg',
                    width: 13,
                    fit: BoxFit.cover,
                    semanticsLabel: 'Near me',
                  ),
                  const SizedBox(width: 10),
                  GetX<UserService>(
                    builder: (controller) {
                      return Text(
                        'в пределах ${controller.searchRadius.value} км',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.36,
                          color: onSurfaceColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
