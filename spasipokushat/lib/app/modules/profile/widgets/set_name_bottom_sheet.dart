import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/profile/profile_controller.dart';

class SetNameBottomSheet extends GetView<ProfileController> {
  const SetNameBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.85,
      maxChildSize: 0.85,
      expand: true,
      builder: (context, ctr) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xffFCFCFC),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _buildDragHand(),
                ),
                _buildTextField(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding,
                  ),
                  child: _buildSaveButton(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller.nameController,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      style: GoogleFonts.ubuntu(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: headingColor,
        height: 1,
      ),
      cursorColor: primaryColor,
      cursorWidth: 2,
      cursorHeight: 34,
      textAlign: TextAlign.center,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        label: Center(
          child: Text(
            'Имя',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: onSurfaceSecondVariantColor,
              height: 0,
            ),
          ),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelStyle: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: onSurfaceSecondVariantColor,
          height: 0,
        ),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildDragHand() {
    return Container(
      width: 32,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xff9C9C9C),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _buildSaveButton() {
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
          onTap: () {
            controller.setName();
          },
          borderRadius: BorderRadius.circular(13),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Сохранить',
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
    );
  }

  double get bottomPadding {
    double res = 0;
    final double bottomSafeArea = Get.mediaQuery.viewPadding.bottom;

    res += bottomSafeArea;

    if (bottomSafeArea == 0) {
      res += 34;
    }

    return res;
  }
}
