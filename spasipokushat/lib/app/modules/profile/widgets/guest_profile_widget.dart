import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/routes/auth_routes.dart';

class GuestProfileWidget extends StatelessWidget {
  const GuestProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: Get.mediaQuery.viewPadding.top + 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeader(),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              width: Get.width * 0.8,
              decoration: ShapeDecoration(
                color: surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F7E7E7E),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _skeletonTileItem('assets/icons/shopping_cart.svg'),
                  _skeletonDivider(),
                  _skeletonTileItem('assets/icons/ring.svg'),
                  _skeletonDivider(),
                  _skeletonTileItem('assets/icons/moon.svg'),
                  _skeletonDivider(),
                  _skeletonTileItem('assets/icons/status.svg'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buldButton(),
          ),
        ],
      ),
    );
  }

  Divider _skeletonDivider() {
    return const Divider(
      color: dividerColor,
      thickness: 1,
      height: 32,
    );
  }

  Padding _skeletonTileItem(String leadingIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            leadingIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Color(0xffC9C8C6),
              BlendMode.srcIn,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/right_arrow.svg',
            width: 4,
            height: 10,
            colorFilter: const ColorFilter.mode(
              Color(0xffA7A7A7),
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Профиль',
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: headingColor,
            height: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Войдите или зарегистрируйтесь, чтобы увидеть информацию',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: onSurfaceColor,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldButton() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(AuthRoutes.auth),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: 60,
            alignment: Alignment.center,
            child: Text(
              'Продолжить',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: onPrimaryColor,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
