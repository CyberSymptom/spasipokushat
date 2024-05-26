import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/routes/onboarding_routes.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';

class HomeRoutes {
  HomeRoutes._();

  static const home = '/home';

  static final routes = [
    GetPage(
        name: home,
        page: () => const HomePage(),
        binding: HomeBinding(),
        middlewares: [HomeMiddleware()]),
  ];
}

class HomeMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserService.to.isFirstAppOpen) {
      return const RouteSettings(name: OnboardingRoutes.onboarding);
    }
    return super.redirect(route);
  }
}
