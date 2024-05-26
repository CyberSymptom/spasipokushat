import 'package:get/get.dart';

import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_page.dart';
import '../modules/profile/about_app/about_app_binding.dart';
import '../modules/profile/about_app/about_app_page.dart';
import '../modules/profile/orders_history/orders_history_binding.dart';
import '../modules/profile/orders_history/orders_history_page.dart';
import '../modules/profile/about_app/app_version/app_version_binding.dart';
import '../modules/profile/about_app/app_version/app_version_page.dart';
import '../modules/profile/orders_history/order_details/order_details_binding.dart';
import '../modules/profile/orders_history/order_details/order_details_page.dart';
import '../modules/profile/orders_history/order_review/order_review_bottom_sheet.dart';

class ProfileRoutes {
  ProfileRoutes._();

  static const profile = '/profile';
  static const aboutApp = '/profile/about-app';
  static const ordersHistory = '/profile/orders-history';
  static const appVersion = '/profile/about-app/app-version';
  static const orderDetails = '/profile/orders-history/order-details';
  static const orderReview = '/profile/orders-history/order-review';

  static final routes = [
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: aboutApp,
      page: () => const AboutAppPage(),
      binding: AboutAppBinding(),
    ),
    GetPage(
      name: ordersHistory,
      page: () => const OrdersHistoryPage(),
      binding: OrdersHistoryBinding(),
    ),
    GetPage(
      name: appVersion,
      page: () => const AppVersionPage(),
      binding: AppVersionBinding(),
    ),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetailsPage(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: orderReview,
      page: () => const OrderReviewBottomSheet(),
    ),
  ];
}
