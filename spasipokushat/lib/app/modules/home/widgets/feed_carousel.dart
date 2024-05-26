
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

import '../../../data/dtos/seller_dto.dart';
import 'widgets.dart';

class FeedCarousel extends StatelessWidget {
  final String carouselTitle;
  final List<SellerDto> sellersList;
  final void Function()? openListPage;
  const FeedCarousel({
    super.key,
    required this.carouselTitle,
    required this.sellersList,
    required this.openListPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeedCarouselTitle(
          title: carouselTitle,
          onTap: openListPage,
        ),
        const SizedBox(height: 12),
        CarouselSlider.builder(
          itemCount: sellersList.length < 5 ? sellersList.length : 5,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: EdgeInsets.only(
                right: index < 4 ? 10 : 0,
                bottom: 8,
              ),
              child: CarouselCard(
                seller: sellersList[index],
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 0.90,
            aspectRatio: 16 / 9.5,
            enableInfiniteScroll: false,
            clipBehavior: Clip.antiAlias,
            disableCenter: false,
            padEnds: true,
            enlargeCenterPage: false,
          ),
        ),
      ],
    );
  }
}
