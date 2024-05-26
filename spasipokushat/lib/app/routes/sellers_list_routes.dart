import 'package:get/get.dart';

import '../modules/sellers_list/sellers_list_binding.dart';
import '../modules/sellers_list/sellers_list_page.dart';

class SellersListRoutes {
  SellersListRoutes._();

  static const sellersList = '/sellers-list';

  static final routes = [
    GetPage(
      name: sellersList,
      page: () => const SellersListPage(),
      binding: SellersListBinding(),
    ),
  ];
}
