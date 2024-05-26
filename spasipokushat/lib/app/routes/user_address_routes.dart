import 'package:get/get.dart';

import '../modules/user_address/user_address_binding.dart';
import '../modules/user_address/user_address_page.dart';

class UserAddressRoutes {
  UserAddressRoutes._();

  static const userAddress = '/user-address';

  static final routes = [
    GetPage(
      name: userAddress,
      page: () => const UserAddressPage(),
      binding: UserAddressBinding(),
    ),
  ];
}
