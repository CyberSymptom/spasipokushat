import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

import 'onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1C1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Image.asset(
        'assets/onboarding.png',
        fit: BoxFit.cover,
      ),
      bottomNavigationBar: _buildBottomContent(),
    );
  }

  Padding _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Спаси Покушать',
            style: GoogleFonts.ubuntu(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: onPrimaryColor,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Качественные продукты по привлекательным '
              'ценам и снижение продовольственных отходов',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xffE7E7E7),
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Container(
              width: double.infinity,
              height: 60,
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
                      'Начать',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Center(
              child: InkWell(
                onTap: controller.openSellerSignPage,
                borderRadius: BorderRadius.circular(10),
                child: Text(
                  'Зарегистрироваться как продавец',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: onPrimaryColor,
                    height: 0,
                    decorationColor: onPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
