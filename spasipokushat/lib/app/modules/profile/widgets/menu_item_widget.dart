import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

class MenuItemWidget extends StatelessWidget {
  final String leadingIconPath;
  final String label;
  final Widget? trailing;
  final double verticalPadding;
  final void Function()? onTap;
  const MenuItemWidget({
    super.key,
    required this.leadingIconPath,
    required this.label,
    required this.onTap,
    this.verticalPadding = 12,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: verticalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    leadingIconPath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 24),
                Text(
                  label,
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: onSurfaceColor,
                    height: 0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(width: 24),
            Builder(
              builder: (context) {
                if (trailing == null) {
                  return SvgPicture.asset(
                    'assets/icons/right_arrow.svg',
                    width: 5,
                    height: 12,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Color(0xffA7A7A7),
                      BlendMode.srcIn,
                    ),
                  );
                } else {
                  return trailing!;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
