import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';

import 'seller_controller.dart';

class SellerPage extends GetView<SellerController> {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((seller) => _LoadedState(seller: seller!),
          onLoading: const Center(
            child: CircularProgressIndicator(),
          )),
      bottomNavigationBar: controller.obx((seller) {
        return GestureDetector(
          onTap: () {
            controller.openOrderPage(seller!);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(22, 12, 22, 34),
            width: double.infinity,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              'Забронировать',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: onPrimaryColor,
                height: 1,
              ),
            ),
          ),
        );
      }, onLoading: const SizedBox.shrink()),
    );
  }
}

class _LoadedState extends GetView<SellerController> {
  final SellerDto seller;
  const _LoadedState({required this.seller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderWidget(),
          _buildProductDetailsWidget(),
          _buildAddressWidget(),
          _buildPackageDescriptionWidget(),
          _buildRatingWidget(),
          _ReviewsCarouselWidget(reviews: seller.reviews),
        ],
      ),
    );
  }

  Padding _buildRatingWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seller.rating,
                style: GoogleFonts.ubuntu(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: headingColor,
                  height: 0,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 13,
                    height: 13,
                    colorFilter: ColorFilter.mode(
                      double.parse(seller.rating) >= 1
                          ? Colors.black
                          : const Color(0xffDEDEDE),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 13,
                    height: 13,
                    colorFilter: ColorFilter.mode(
                      double.parse(seller.rating) >= 2
                          ? Colors.black
                          : const Color(0xffDEDEDE),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 13,
                    height: 13,
                    colorFilter: ColorFilter.mode(
                      double.parse(seller.rating) >= 3
                          ? Colors.black
                          : const Color(0xffDEDEDE),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 13,
                    height: 13,
                    colorFilter: ColorFilter.mode(
                      double.parse(seller.rating) >= 4
                          ? Colors.black
                          : const Color(0xffDEDEDE),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 2),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 13,
                    height: 13,
                    colorFilter: ColorFilter.mode(
                      double.parse(seller.rating) >= 5
                          ? Colors.black
                          : const Color(0xffDEDEDE),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _ReviewsWidget(
                reviewsQuantity: seller.reviews.length,
              ),
            ],
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _RateBarWidget(
                  rate: 5,
                  reviews: seller.reviews,
                ),
                const SizedBox(height: 2),
                _RateBarWidget(
                  rate: 4,
                  reviews: seller.reviews,
                ),
                const SizedBox(height: 2),
                _RateBarWidget(
                  rate: 3,
                  reviews: seller.reviews,
                ),
                const SizedBox(height: 2),
                _RateBarWidget(
                  rate: 2,
                  reviews: seller.reviews,
                ),
                const SizedBox(height: 2),
                _RateBarWidget(
                  rate: 1,
                  reviews: seller.reviews,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPackageDescriptionWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22.0, 16, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Что внутри?',
            style: GoogleFonts.ubuntu(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: headingColor,
              height: 0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            seller.productDescription,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: onSurfaceColor,
              height: 0,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 0,
            color: dividerColor,
          )
        ],
      ),
    );
  }

  Padding _buildAddressWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22.0, 16, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/location.svg',
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  seller.pickupAddress,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: headingColor,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextButton(
              onPressed: () {
                UtilsHelper.openYandexMap(
                  seller.point.latitude,
                  seller.point.latitude,
                );
              },
              child: Text(
                'Маршрут',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 0,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            height: 0,
            color: dividerColor,
          ),
        ],
      ),
    );
  }

  Padding _buildProductDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22.0, 24, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => controller.openAboutPage(seller),
                child: Text(
                  seller.name,
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: headingColor,
                    height: 0,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${seller.salePrice?.toInt() ?? seller.regularPrice.toInt()}₽',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF252525),
                      height: 0,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (seller.salePrice == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          '${seller.regularPrice.toInt()}₽',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: outlineColor,
                            height: 0,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: outlineColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            seller.productName,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: onSurfaceColor,
              height: 0,
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Забрать с'),
                TextSpan(
                  text: '${seller.pickupTime[0]} '
                      'до ${seller.pickupTime[1]} ',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: onSurfaceColor,
                    height: 0,
                  ),
                ),
              ],
            ),
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: onSurfaceColor,
              height: 0,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(height: 0, color: dividerColor),
        ],
      ),
    );
  }

  AspectRatio _buildHeaderWidget() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: seller.thumbnailUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Get.mediaQuery.viewPadding.top + 24,
            left: 16,
            child: GestureDetector(
              onTap: Get.back,
              child: Container(
                width: 35,
                height: 35,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: onPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset('assets/icons/left_arrow.svg'),
              ),
            ),
          ),
          Positioned(
            top: Get.mediaQuery.viewPadding.top + 24,
            right: 16,
            child: Obx(() {
              final homeC = Get.find<HomeController>();
              final bool isFavorite = homeC.isSellerFavorite(seller);
              return GestureDetector(
                onTap: () {
                  isFavorite
                      ? homeC.removeFromFavorite(seller)
                      : homeC.addSellerToFavorite(seller);
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
          Positioned(
            bottom: 28,
            left: 16,
            child: Container(
              alignment: Alignment.center,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 12.5),
              decoration: BoxDecoration(
                color: onPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${seller.productQuantity} шт.',
                style: GoogleFonts.ubuntu(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: headingColor,
                ),
              ),
            ),
          ),
          Visibility(
            visible: seller.reviews.isEmpty ? false : true,
            child: Positioned(
              bottom: 28,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  controller.openReviewsPage(seller);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 12.5),
                  decoration: BoxDecoration(
                    color: onPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/star.svg',
                        width: 13,
                        height: 13,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Color(0xffFFC107),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${seller.rating} (${seller.reviews.length})',
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: headingColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              if (seller.logoUrl == null) {
                return const SizedBox.shrink();
              }
              return Center(
                child: GestureDetector(
                  onTap: () => controller.openAboutPage(seller),
                  child: CachedNetworkImage(
                    imageUrl: seller.logoUrl!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 150,
                        height: 150,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: imageProvider),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ReviewsWidget extends StatelessWidget {
  final int reviewsQuantity;

  const _ReviewsWidget({required this.reviewsQuantity});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getFormattedQuantity(reviewsQuantity)} оцен${_getSuffix(reviewsQuantity)}',
      style: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 0,
        color: Colors.black,
      ),
    );
  }

  String _getFormattedQuantity(int quantity) {
    final format = NumberFormat.compact(locale: 'ru');
    return format.format(quantity);
  }

  String _getSuffix(int quantity) {
    if (quantity % 10 == 1 && quantity % 100 != 11) {
      return 'ка';
    } else if ((quantity % 10 >= 2 && quantity % 10 <= 4) &&
        (quantity % 100 < 10 || quantity % 100 >= 20)) {
      return 'ки';
    } else {
      return 'ок';
    }
  }
}

class _RateBarWidget extends StatelessWidget {
  final int rate;
  final List<ReviewDto> reviews;

  const _RateBarWidget({required this.rate, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(builder: (context) {
          if (percentage == 0) {
            return const SizedBox.shrink();
          }
          return Flexible(
            flex: percentage,
            child: Container(
              margin: const EdgeInsets.only(right: 2),
              height: 2,
              color: headingColor,
            ),
          );
        }),
        Flexible(
          flex: 100 - percentage,
          child: Container(
            height: 1,
            color: const Color(0xffDEDEDE),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 40,
          child: Text(
            '$percentage%',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              height: 0,
              color: percentageTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Color get percentageTextColor {
    return percentage == 0 ? const Color(0xffDEDEDE) : headingColor;
  }

  int get percentage {
    if (reviews.isEmpty) {
      return 0;
    }
    return ((100 / reviews.length) * reviewsByRate).toInt();
  }

  int get reviewsByRate {
    return reviews.fold(
      0,
      (previousValue, element) =>
          element.rate == rate ? previousValue += 1 : previousValue,
    );
  }
}

class _ReviewsCarouselWidget extends StatelessWidget {
  final List<ReviewDto> reviews;
  const _ReviewsCarouselWidget({
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(top: 29, bottom: 24),
      height: 144,
      alignment: Alignment.topCenter,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          return _buildReviewCard(reviews[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: reviews.length,
      ),
    );
  }

  Widget _buildReviewCard(ReviewDto review) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [cardShadow],
      ),
      margin: const EdgeInsets.only(bottom: 8),
      width: Get.width * 0.6,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.name!,
                style: GoogleFonts.ubuntu(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: headingColor,
                  height: 0,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 0 : 1.0),
                    child: SvgPicture.asset(
                      'assets/icons/star.svg',
                      width: 10,
                      height: 10,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        index + 1 <= review.rate
                            ? headingColor
                            : const Color(0xffDEDEDE),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _ReviewDateWidget(reviewDate: review.createdAt!),
          const SizedBox(height: 24),
          Text(
            '${review.review!} ${review.review!} ${review.review!}',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: onSurfaceColor,
              height: 0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ReviewDateWidget extends StatelessWidget {
  final DateTime reviewDate;

  const _ReviewDateWidget({required this.reviewDate});

  @override
  Widget build(BuildContext context) {
    return Text(
      _getFormattedReviewDate(reviewDate),
      style: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: onSurfaceColor,
        height: 0,
      ),
    );
  }

  String _getFormattedReviewDate(DateTime reviewDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (reviewDate.year == today.year &&
        reviewDate.month == today.month &&
        reviewDate.day == today.day) {
      return 'Сегодня';
    } else if (reviewDate.year == yesterday.year &&
        reviewDate.month == yesterday.month &&
        reviewDate.day == yesterday.day) {
      return 'Вчера';
    } else if (reviewDate.isAfter(yesterday) && reviewDate.isBefore(today)) {
      final difference = today.difference(reviewDate);
      final daysAgo = difference.inDays;

      if (daysAgo == 1) {
        return '1 день назад';
      } else {
        return '$daysAgo ${_daysAgoFormat(daysAgo)} назад';
      }
    } else if (reviewDate.isAfter(today.subtract(const Duration(days: 7))) &&
        reviewDate.isBefore(today)) {
      return _formatWeekday(reviewDate.weekday);
    } else {
      return DateFormat('dd.MM.yyyy').format(reviewDate);
    }
  }

  String _daysAgoFormat(int days) {
    if (days >= 11 && days <= 14) {
      return 'дней';
    } else {
      final lastDigit = days % 10;
      if (lastDigit == 1) {
        return 'день';
      } else if (lastDigit >= 2 && lastDigit <= 4) {
        return 'дня';
      } else {
        return 'дней';
      }
    }
  }

  String _formatWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Понедельник';
      case 2:
        return 'Вторник';
      case 3:
        return 'Среда';
      case 4:
        return 'Четверг';
      case 5:
        return 'Пятница';
      case 6:
        return 'Суббота';
      case 7:
        return 'Воскресенье';
      default:
        return '';
    }
  }
}
