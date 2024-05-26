
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';

class RadiusSelectionBottomSheet extends StatelessWidget {
  const RadiusSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> values = [
      5.0,
      7.0,
      10.0,
      15.0,
      20.0,
      30.0,
      40.0,
      50.0,
      100.0,
    ];

    final initialValue = values
        .indexWhere((element) => element == UserService.to.searchRadius.value);

    return ValueBuilder<int?>(
      initialValue: initialValue,
      builder: (selectedIndex, updateFn) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandWidget(),
            _buildDistanceTextWidget(values, selectedIndex),
            _buildSliderRadiusWidget(selectedIndex, values, updateFn),
            _buildSaveButton(values, selectedIndex),
          ],
        );
      },
    );
  }

  Padding _buildDistanceTextWidget(List<double> values, int? selectedIndex) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 9, 25, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Расстояние поиска',
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: headingColor,
            ),
          ),
          Text(
            '${values[selectedIndex!].toInt()} км',
            style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: headingColor,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildSaveButton(List<double> values, int? selectedIndex) {
    return GestureDetector(
      onTap: () {
        Get.back();
        UserService.to.updateSearchRadius(
          values[selectedIndex!].toInt(),
        );
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 34),
        padding: const EdgeInsets.all(17.5),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          'Сохранить',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 0,
            color: onPrimaryColor,
          ),
        ),
      ),
    );
  }

  Padding _buildSliderRadiusWidget(int? selectedIndex, List<double> values,
      ValueBuilderUpdateCallback<int?> updateFn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Slider(
        value: selectedIndex!.toDouble(),
        min: 0,
        max: values.length - 1,
        divisions: values.length - 1,
        inactiveColor: const Color(0xFFEADFDD),
        onChanged: (double val) async {
          updateFn(val.toInt());
        },
      ),
    );
  }

  Padding _buildDragHandWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xff9C9C9C),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
