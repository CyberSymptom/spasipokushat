import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';

import 'favorites_controller.dart';
import 'widgets/widgets.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      init: FavoritesController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(
            () {
              final isFavoriteListEmpty =
                  Get.find<HomeController>().state?.favorites.isEmpty;
              if (isFavoriteListEmpty == null || isFavoriteListEmpty) {
                return const EmptyFavoritesWidget();
              }
              return const FavoritesWidget();
            },
          ),
        );
      },
    );
  }
}
