import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/favorites/favorites_controller.dart';

class EmptyFavoritesWidget extends GetView<FavoritesController> {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(22, topPadding, 22, 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildHeading(),
          const SizedBox(height: 18, width: double.infinity),
          _buildSkeletonCard(),
          const Spacer(),
          _buildReturnButton(),
        ],
      ),
    );
  }

  Column _buildHeading() {
    return Column(
      children: [
        Text(
          'Вы еще не добавили понравившиеся заведения',
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
            'Нажмите на сердечко в карточке понравившегося '
            'заведения, чтобы добавить его в избранное',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: onSurfaceColor,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }

  Center _buildSkeletonCard() {
    return Center(
      child: SizedBox(
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0, bottom: 34),
                child: SvgPicture.asset('assets/icons/big_arrow.svg'),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 173,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [cardShadow],
                  ),
                ),
                Container(
                  height: 116,
                  width: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xffF1F1F1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(8.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/favorite_unselected.svg',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildReturnButton() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.openHomePage,
          borderRadius: BorderRadius.circular(13),
          child: Center(
            child: Text(
              'Вернуться на главную',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: onPrimaryColor,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get topPadding {
    double res = 0;
    res += Get.mediaQuery.viewPadding.top;

    if (res == 0) {
      res += 54;
    } else {
      res += 24;
    }
    return res;
  }
}
