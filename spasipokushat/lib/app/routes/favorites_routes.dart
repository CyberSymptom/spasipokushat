import 'package:get/get.dart';

import '../modules/favorites/favorites_binding.dart';
import '../modules/favorites/favorites_page.dart';

class FavoritesRoutes {
  FavoritesRoutes._();

  static const favorites = '/favorites';

  static final routes = [
    GetPage(
      name: favorites,
      page: () => const FavoritesPage(),
      binding: FavoritesBinding(),
    ),
  ];
}
