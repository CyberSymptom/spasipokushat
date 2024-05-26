import 'home_routes.dart';
import 'auth_routes.dart';
import 'map_routes.dart';
import 'favorites_routes.dart';
import 'profile_routes.dart';
import 'user_address_routes.dart';
import 'seller_routes.dart';
import 'sellers_list_routes.dart';
import 'order_routes.dart';
import 'onboarding_routes.dart';
import 'seller_quiz_form_routes.dart';

class AppPages {
  AppPages._();

  static const initial = '/home';

  static final routes = [
    ...HomeRoutes.routes,
		...AuthRoutes.routes,
		...MapRoutes.routes,
		...FavoritesRoutes.routes,
		...ProfileRoutes.routes,
		...UserAddressRoutes.routes,
		...SellerRoutes.routes,
		...SellersListRoutes.routes,
		...OrderRoutes.routes,
		...OnboardingRoutes.routes,
		...SellerQuizFormRoutes.routes,
  ];
}
