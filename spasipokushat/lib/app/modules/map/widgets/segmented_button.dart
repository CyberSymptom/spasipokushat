import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/map/map_controller.dart';

class SegmentedButtonWidget extends GetView<MapController> {
  const SegmentedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffD5D5D5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.selectedIndex.value = 0,
              child: Obx(
                () => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 0
                        ? primaryColor
                        : surfaceColor,
                    border: const Border(
                      right: BorderSide(
                        width: 0.5,
                        color: Color(0xffD5D5D5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Карта',
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: controller.selectedIndex.value == 0
                          ? FontWeight.w500
                          : FontWeight.normal,
                      color: controller.selectedIndex.value == 0
                          ? onPrimaryColor
                          : onSurfaceColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.selectedIndex.value = 1,
              child: Obx(
                () => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == 1
                        ? primaryColor
                        : surfaceColor,
                    border: const Border(
                      left: BorderSide(
                        width: 0.5,
                        color: Color(0xffD5D5D5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Список',
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: controller.selectedIndex.value == 1
                          ? FontWeight.w500
                          : FontWeight.normal,
                      color: controller.selectedIndex.value == 1
                          ? onPrimaryColor
                          : onSurfaceColor,
                    ),
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
