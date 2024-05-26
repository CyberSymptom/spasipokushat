import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/repositories/auth_repository.dart';
import 'package:spasipokushat/app/modules/auth/otp/otp_controller.dart';
import 'package:spasipokushat/app/modules/auth/otp/otp_page.dart';
import 'package:spasipokushat/app/modules/auth/otp/otp_pages.dart';

import 'auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 22.0,
          top: Get.mediaQuery.viewPadding.top + 40,
          right: 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Введите номер телефона',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: headingColor,
                height: 0,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Чтобы войти или зарегистрироваться',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: onSurfaceColor,
                height: 0,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.phoneController,
              // focusNode: controller.phoneNode,
              autofocus: true,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              cursorColor: const Color(0xffA7A7A7),
              inputFormatters: [controller.maskFormatter],
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                color: onSurfaceColor,
              ),
              decoration: InputDecoration(
                labelText: 'Номер телефона',
                floatingLabelStyle: GoogleFonts.nunito(
                  color: const Color(0xffA7A7A7),
                ),
                suffixIcon: IconButton(
                  onPressed: () => controller.phoneController.clear(),
                  icon: SvgPicture.asset('assets/icons/erase.svg'),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffA7A7A7),
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffA7A7A7),
                    width: 2,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffA7A7A7),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()),);
                // controller.sendOtpCode();
                controller.toOtp(context);
              },
              child: Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(13),
                ),
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
          ],
        ),
      ),
    );
  }
}
