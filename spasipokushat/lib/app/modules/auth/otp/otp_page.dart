import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

import 'otp_controller.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});

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
              'Введите код подтверждения',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: headingColor,
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22.0, 60, 22, 0),
              child: Center(
                child: PinCodeTextField(
                  appContext: context,
                  autoFocus: true,
                  autoUnfocus: true,
                  controller: controller.pinController,
                  length: 6,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  autoDismissKeyboard: false,
                  onCompleted: (value) {
                    controller.completeOtpVerification(value);
                  },
                  textStyle: GoogleFonts.ubuntu(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: headingColor,
                    height: 0,
                  ),
                  cursorColor: const Color(0xff191919),
                  cursorWidth: 2,
                  pinTheme: PinTheme(
                    activeColor: const Color(0xffA7A7A7),
                    selectedColor: const Color(0xffA7A7A7),
                    inactiveColor: const Color(0xffA7A7A7),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 34),
            _resendOtpButton(),
            GestureDetector(
              onTap: () {
                controller.changePhoneNubmer();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 11),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: Get.width,
                child: Text(
                  'Изменить номер телефона',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: onSurfaceColor,
                    height: 0,
                    decoration: TextDecoration.underline,
                    decorationColor: onSurfaceColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resendOtpButton() {
    return Obx(() {
      final canResendOtp = controller.canResendOtp.value;
      return GestureDetector(
        onTap: !canResendOtp ? null : () => controller.resendOtp(),
        child: Container(
          width: double.infinity,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: canResendOtp ? primaryColor : primaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text(
            canResendOtp
                ? 'Отправить код повторно'
                : 'Запросить через ${controller.secondsRemaining.value} сек',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: onPrimaryColor,
              height: 0,
            ),
          ),
        ),
      );
    });
  }
}
