import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/profile/orders_history/order_review/order_review_controller.dart';

class ReviewField extends GetView<OrderReviewController> {
  const ReviewField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.done,
      focusNode: controller.focusNode,
      minLines: 1,
      maxLines: 3,
      maxLength: 250,
      cursorColor: headingColor,
      cursorHeight: 16,
      style: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: headingColor,
      ),
      decoration: InputDecoration(
        hintText: 'Расскажите о своих впечатлениях',
        hintStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: onSurfaceSecondVariantColor,
          height: 0,
        ),
        helperStyle: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: headingColor,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: outlineColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: outlineColor),
        ),
      ),
    );
  }
}
