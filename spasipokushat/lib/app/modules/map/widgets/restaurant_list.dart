import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/modules/map/map_controller.dart';

class RestaurantList extends GetView<MapController> {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.sellers.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      height: 109,
      width: Get.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, int index) {
          return restaurantCard(controller.sellers[index]);
        },
        separatorBuilder: (context, int index) {
          return const SizedBox(width: 16);
        },
        itemCount: controller.sellers.length,
      ),
    );
  }

  Widget restaurantCard(SellerDto seller) {
    return GestureDetector(
      onTap: () => controller.openSellerPage(seller: seller),
      child: Container(
        height: 109,
        width: Get.width * 0.7,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [cardShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: seller.logoUrl!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    seller.name,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: headingColor,
                      height: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    seller.productName,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: onSurfaceColor,
                      height: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'с ${seller.pickupTime[0]} до ${seller.pickupTime[1]}',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: onSurfaceColor,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
