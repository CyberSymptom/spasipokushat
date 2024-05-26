import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/data/dtos/sellers_response_dto.dart';
import 'package:spasipokushat/app/modules/favorites/favorites_page.dart';
import 'package:spasipokushat/app/modules/map/map_page.dart';
import 'package:spasipokushat/app/modules/profile/profile_page.dart';

import 'home_controller.dart';
import 'widgets/widgets.dart';
part 'widgets/feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          final List<Widget> bodys = [
            const _Feed(),
            const MapPage(),
            const FavoritesPage(),
            const ProfilePage(),
          ];

          return bodys[controller.selectedIndex];
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
