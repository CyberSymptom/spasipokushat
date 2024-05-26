import 'package:flutter/material.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';

class MenuItemDividerWidget extends StatelessWidget {
  const MenuItemDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: dividerColor,
      thickness: 1,
      height: 20,
    );
  }
}
