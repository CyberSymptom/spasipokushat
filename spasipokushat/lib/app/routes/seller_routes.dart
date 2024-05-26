import 'package:get/get.dart';

import '../modules/seller/seller_binding.dart';
import '../modules/seller/seller_page.dart';
import '../modules/seller/reviews/reviews_binding.dart';
import '../modules/seller/reviews/reviews_page.dart';
import '../modules/seller/about/about_binding.dart';
import '../modules/seller/about/about_page.dart';

class SellerRoutes {
  SellerRoutes._();

  static const seller = '/seller';
	static const reviews = '/seller/reviews';
	static const about = '/seller/about';

  static final routes = [
    GetPage(
      name: seller,
      page: () => const SellerPage(),
      binding: SellerBinding(),
      
    ),
		GetPage(
      name: reviews,
      page: () => const ReviewsPage(),
      binding: ReviewsBinding(),
    ),
		GetPage(
      name: about,
      page: () => const AboutPage(),
      binding: AboutBinding(),
    ),
  ];
}
