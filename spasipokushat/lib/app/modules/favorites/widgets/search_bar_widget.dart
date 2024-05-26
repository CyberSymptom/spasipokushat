import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/modules/favorites/favorites_controller.dart';

class SearchBarWidget extends GetView<FavoritesController> {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.openSearchPage,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffD5D5D5),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/search.svg',
              width: 24,
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Поиск',
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xffA7A7A7),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
