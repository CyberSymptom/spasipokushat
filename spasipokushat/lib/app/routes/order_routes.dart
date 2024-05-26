import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/routes/auth_routes.dart';

import '../modules/order/order_binding.dart';
import '../modules/order/order_page.dart';

class OrderRoutes {
  OrderRoutes._();

  static const order = '/order';
	static const payment = '/order/payment';

  static final routes = [
    GetPage(
      name: order,
      page: () => const OrderPage(),
      binding: OrderBinding(),
      middlewares: [OrderMiddleware()],
    ),
		
  ];
}

class OrderMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserService.to.user.value == null) {
      return const RouteSettings(name: AuthRoutes.auth);
    }
    return super.redirect(route);
  }
}
