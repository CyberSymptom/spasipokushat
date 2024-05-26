import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: primaryColor,
    onSecondary: onPrimaryColor,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: onSurfaceColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    primaryContainer: primaryColor,
    onPrimaryContainer: onPrimaryColor,
    outline: outlineColor,
    shadow: const Color(0xff7f7f7f40).withOpacity(0.25),
  ),
  scaffoldBackgroundColor: Colors.white,
  dividerColor: dividerColor,
  sliderTheme: SliderThemeData(
    trackShape: CustomTrackShape(),
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return GoogleFonts.ubuntu(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: const Color(0xff2E2E32),
          );
        }
        return GoogleFonts.ubuntu(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: const Color(0xff9C9C9C),
        );
      },
    ),
  ),
);

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
