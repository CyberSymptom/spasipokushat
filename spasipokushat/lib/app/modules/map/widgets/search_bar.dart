import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/map/map_controller.dart';

import '../../home/widgets/widgets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: Get.width,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffD5D5D5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => showSearch(
            context: context,
            delegate: SellerSearch(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 20),
                Text(
                  'Поиск',
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffA7A7A7),
                    height: 0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SellerSearch extends SearchDelegate {
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
    final res = Get.find<MapController>()
        .sellers
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
    final res = Get.find<MapController>()
        .sellers
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
