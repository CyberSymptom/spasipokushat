import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';

import 'reviews_controller.dart';

class ReviewsPage extends GetView<ReviewsController> {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final seller = Get.arguments as SellerDto;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: Get.back,
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingWidget(),
          _buildHeading(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 34),
              itemBuilder: (context, int index) {
                return _buildReviewCard(seller.reviews[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: seller.reviews.length,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildHeading() {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, top: 34, bottom: 24),
      child: Text(
        'Отзывы',
        style: GoogleFonts.ubuntu(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: headingColor,
          height: 0,
        ),
      ),
    );
  }

  Padding _buildRatingWidget() {
    final seller = Get.arguments as SellerDto;
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _buildReviewCard(ReviewDto review) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [cardShadow],
      ),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
        Flexible(
          flex: percentage,
          child: Container(
            margin: const EdgeInsets.only(right: 2),
            height: 2,
            color: headingColor,
          ),
        ),
        Flexible(
          flex: 100 - percentage,
          child: Container(
            height: 1,
            color: const Color(0xffDEDEDE),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$percentage%',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 0,
            color: percentageTextColor,
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
