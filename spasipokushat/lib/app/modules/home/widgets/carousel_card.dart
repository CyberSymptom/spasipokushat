import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';

import '../../../core/theme/colors.dart';
import '../home_controller.dart';

class CarouselCard extends GetView<HomeController> {
  final SellerDto seller;
  const CarouselCard({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<HomeController>().openSellerPage(seller);
      },
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [cardShadow],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: seller.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 16,
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Builder(
                        builder: (context) {
                          if (seller.productQuantity < 5) {
                            return Text(
                              '${seller.productQuantity} шт.',
                              style: GoogleFonts.ubuntu(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: headingColor,
                              ),
                            );
                          }
                          return Text(
                            '${seller.productQuantity}+ шт.',
                            style: GoogleFonts.ubuntu(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: headingColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 16,
                    child: Obx(() {
                      final bool isFavorite =
                          controller.isSellerFavorite(seller);
                      return GestureDetector(
                        onTap: () {
                          isFavorite
                              ? controller.removeFromFavorite(seller)
                              : controller.addSellerToFavorite(seller);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(8.5),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            isFavorite
                                ? 'assets/icons/favorite_selected.svg'
                                : 'assets/icons/favorite_unselected.svg',
                            height: 18,
                            width: 18,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    seller.name,
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                      height: 1.0,
                      fontWeight: FontWeight.normal,
                      color: headingColor,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 15,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        seller.rating,
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: headingColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12, width: double.infinity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      seller.productName,
                      style: GoogleFonts.ubuntu(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: onSurfaceColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          if (seller.salePrice != null) {
                            return Text(
                              '${seller.salePrice!.toInt()}₽',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff262626),
                                height: 1.0,
                              ),
                            );
                          }
                          return Text(
                            '${seller.regularPrice.toInt()}₽',
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff262626),
                              height: 1.0,
                            ),
                          );
                        },
                      ),
                      Visibility(
                        visible: seller.salePrice == null ? false : true,
                        child: const SizedBox(width: 6),
                      ),
                      Builder(
                        builder: (context) {
                          if (seller.salePrice != null) {
                            return Text(
                              '${seller.regularPrice.toInt()}₽',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: onSurfaceVariantColor,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: onSurfaceVariantColor,
                                height: 1.0,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
