import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(22.0, topPadding, 22, 0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(),
          Expanded(
            child: SellersListWidget(),
          ),
        ],
      ),
    );
  }

  double get topPadding {
    double res = 0;
    res += Get.mediaQuery.viewPadding.top;

    if (res == 0) {
      res += 54;
    } else {
      res += 24;
    }
    return res;
  }
}
