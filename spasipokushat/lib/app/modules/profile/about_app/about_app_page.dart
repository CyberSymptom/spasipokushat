import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

import 'about_app_controller.dart';

class AboutAppPage extends GetView<AboutAppController> {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/left_arrow.svg',
            width: 18,
            height: 18,
          ),
        ),
        title: Text(
          'О приложении',
          style: GoogleFonts.ubuntu(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: headingColor,
            height: 0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22.0, top: 24, right: 22),
        child: Column(
          children: [
            _buildMenuItem(
              label: 'Политика конфиденциальности',
              onTap: controller.openPrivacyPolicyPage,
            ),
            _buildMenuDivider(),
            _buildMenuItem(
              label: 'Пользовательское соглашение',
              onTap: controller.openUserAgreementPage,
            ),
            _buildMenuDivider(),
            _buildMenuItem(
              label: 'Версия приложения',
              onTap: controller.openAppVersionPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDivider() {
    return const Divider(
      color: dividerColor,
      height: 24,
      thickness: 1,
    );
  }

  Widget _buildMenuItem({
    required String label,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: onSurfaceColor,
                height: 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'assets/icons/right_arrow.svg',
                width: 6,
                height: 14,
                colorFilter: const ColorFilter.mode(
                  Color(0xffA7A7A7),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
