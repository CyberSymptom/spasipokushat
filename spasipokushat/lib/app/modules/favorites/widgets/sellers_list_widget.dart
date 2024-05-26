import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';
import 'package:spasipokushat/app/modules/home/widgets/widgets.dart';

class SellersListWidget extends StatelessWidget {
  const SellersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteSellers = Get.find<HomeController>().state!.favorites;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 16 / 9.5,
          child: CarouselCard(seller: favoriteSellers[index]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: favoriteSellers.length,
    );
  }
}
