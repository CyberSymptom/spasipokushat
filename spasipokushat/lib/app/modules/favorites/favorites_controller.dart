import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';

import 'widgets/widgets.dart';

class FavoritesController extends GetxController {
  void openHomePage() {
    Get.find<HomeController>().changePage(0);
  }

  void openSearchPage() {
    showSearch(
      context: Get.context!,
      delegate: SearchPageDelegate(),
    );
  }
}
