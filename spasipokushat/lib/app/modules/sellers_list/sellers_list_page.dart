import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';

import '../home/widgets/widgets.dart';
import 'sellers_list_controller.dart';

class SellersListPage extends GetView<SellersListController> {
  const SellersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sellers = Get.arguments as List<SellerDto>;
    final String title = Get.parameters['title']!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: surfaceColor,
        title: Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xff4D4D4D),
            height: 0,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 34),
        itemBuilder: (context, int index) {
          return AspectRatio(
            aspectRatio: 16 / 9.5,
            child: CarouselCard(seller: sellers[index]),
          );
        },
        separatorBuilder: (context, int intdex) {
          return const SizedBox(height: 16);
        },
        itemCount: sellers.length,
      ),
    );
  }
}
