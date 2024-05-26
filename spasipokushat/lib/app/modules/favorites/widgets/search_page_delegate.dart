import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';

import '../../home/widgets/carousel_card.dart';

class SearchPageDelegate extends SearchDelegate {
  final favoriteSellers = Get.find<HomeController>().state!.favorites;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: Get.back,
      icon: SvgPicture.asset(
        'assets/icons/left_arrow.svg',
        width: 18,
        height: 18,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final res = favoriteSellers
        .where(
          (element) =>
              element.name.toLowerCase().startsWith(query.toLowerCase()),
        )
        .toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
      itemBuilder: (context, int index) {
        return AspectRatio(
          aspectRatio: 16 / 9.5,
          child: CarouselCard(seller: res[index]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: res.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query.length < 3) {
      return const SizedBox.shrink();
    }
    final res = favoriteSellers
        .where(
          (element) =>
              element.name.toLowerCase().startsWith(query.toLowerCase()),
        )
        .toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
      itemBuilder: (context, int index) {
        return AspectRatio(
          aspectRatio: 16 / 9.5,
          child: CarouselCard(seller: res[index]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: res.length,
    );
  }
}
