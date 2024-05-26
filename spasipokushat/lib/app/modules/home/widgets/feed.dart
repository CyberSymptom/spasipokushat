part of '../home_page.dart';

class _Feed extends GetView<HomeController> {
  const _Feed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderBar(),
            controller.obx(
              (sellersResp) {
                return Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 76,
                        ),
                        child: Column(
                          children: [
                            FeedCarousel(
                              carouselTitle: 'Рекомендации для вас',
                              sellersList: sellersResp!.recomended,
                              openListPage: () =>
                                  controller.openSellersListPage(
                                sellersResp.recomended,
                                'Рекомендации для вас',
                              ),
                            ),
                            const SizedBox(height: 16),
                            FeedCarousel(
                              carouselTitle: 'Исследуйте новые места',
                              sellersList: sellersResp.newPlaces,
                              openListPage: () =>
                                  controller.openSellersListPage(
                                sellersResp.newPlaces,
                                'Исследуйте новые места',
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                if (sellersResp.favorites.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: FeedCarousel(
                                    carouselTitle: 'Избранное',
                                    sellersList: sellersResp.favorites,
                                    openListPage: () =>
                                        controller.openSellersListPage(
                                      sellersResp.favorites,
                                      'Избранное',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: sellersResp.activeOrder != null ,
                        child: Positioned(
                          bottom: 8,
                          left: 16,
                          right: 16,
                          child: _currentOrder(sellersResp),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onEmpty: Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  alignment: Alignment.center,
                  child: Text(
                    'Рядом с вами пока нет доступных точек. '
                    'Попробуйте расширить радиус поиска',
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: headingColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _currentOrder(SellersResponseDto sellersResp) {
    return Container(
      width: double.infinity,
      height: 61,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [cardShadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.openOrderDetails,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      width: 17,
                      height: 17,
                      colorFilter: const ColorFilter.mode(
                        Color(0xff252525),
                        BlendMode.srcIn,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        '${sellersResp.activeOrder?.status.value}',
                        style: GoogleFonts.ubuntu(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: onSurfaceColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        'Заказ № ${sellersResp.activeOrder?.orderNumber}',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: headingColor,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Заберите с '
                    '${sellersResp.activeOrder?.seller.pickupTime[0]} '
                    'до ${sellersResp.activeOrder?.seller.pickupTime[0]}',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: headingColor,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
