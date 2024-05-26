
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return NavigationBar(
          indicatorColor: Colors.transparent,
          backgroundColor: const Color(0xffFCFCFC),
          elevation: 0,
          selectedIndex: controller.selectedIndex,
          onDestinationSelected: controller.changePage,
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_home.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff9C9C9C),
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_home.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff2E2E32),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Главная',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_search.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff9C9C9C),
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_search.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff2E2E32),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Карта',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_favorites.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff9C9C9C),
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_favorites.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff2E2E32),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Избранное',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_profile.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff9C9C9C),
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/bottom_nav_bar_profile.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xff2E2E32),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Профиль',
            ),
          ],
        );
      },
    );
  }
}
