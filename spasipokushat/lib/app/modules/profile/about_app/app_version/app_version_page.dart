import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

import 'app_version_controller.dart';

class AppVersionPage extends GetView<AppVersionController> {
  const AppVersionPage({super.key});

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
          'Версия приложения',
          style: GoogleFonts.ubuntu(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: headingColor,
            height: 0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeading('1.0.0'),
            _buildUpdatesList(
              updates: [
                _buildBulletPoint(
                  'Первая версия приложения',
                ),
              ],
            ),
            Text(
              'Мы прилагаем максимум усилий для улучшения вашего опыта '
              'использования "Спаси покушать". Благодарим за использование '
              'нашего сервиса!',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: headingColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String versionNumber) {
    return Text(
      'Версия приложения: $versionNumber',
      style: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: headingColor,
        height: 0,
      ),
    );
  }

  Widget _buildUpdatesList({required List<Widget> updates}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 22.0,
        bottom: 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Обновления:',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: headingColor,
              height: 0,
            ),
          ),
          ...updates,
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    final TextStyle textStyle = GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: headingColor,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "• ",
          style: textStyle,
        ),
        Expanded(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
