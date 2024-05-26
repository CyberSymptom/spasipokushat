import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:spasipokushat/app/modules/profile/profile_controller.dart';

import 'widgets.dart';

class UserProfileWidget extends GetView<ProfileController> {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 22.0,
        right: 22.0,
        top: Get.mediaQuery.viewPadding.top + 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12),
            child: _buildPhone(),
          ),
          _buildProfileMenuList(),
          const Spacer(),
          _buildExitButton(),
          const SizedBox(height: 16),
          OutlineButtonWidget(
            label: 'Удалить аккаунт',
            iconPath: 'assets/icons/remove.svg',
            onTap: controller.deleteProfile,
          ),
          const SizedBox(height: 16),
          OutlineButtonWidget(
            label: 'Стать продавцом',
            iconPath: 'assets/icons/wallet.svg',
            onTap: controller.becomeSeller,
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }

  Widget _buildName() {
    return GetX<ProfileController>(
      builder: (controller) {
        return GestureDetector(
          onTap: controller.showSetNameBottomSheet,
          child: Text(
            controller.userName.value,
            style: GoogleFonts.ubuntu(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: headingColor,
              height: 0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhone() {
    return GetX<ProfileController>(
      builder: (controller) {
        if (controller.userPhone.value.isEmpty) {
          return const SizedBox.shrink();
        }
        return Text(
          controller.userPhone.value,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: onSurfaceColor,
            height: 0,
          ),
        );
      },
    );
  }

  Widget _buildProfileMenuList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuItemWidget(
          leadingIconPath: 'assets/icons/shopping_cart.svg',
          label: 'Заказы',
          onTap: () {
            controller.openOrdersHistoryPage();
          },
        ),
        const MenuItemDividerWidget(),
        MenuItemWidget(
          leadingIconPath: 'assets/icons/ring.svg',
          label: 'Уведомления',
          onTap: null,
          verticalPadding: 4,
          trailing: Obx(
            () => Switch.adaptive(
              value: controller.notificationStatus.value,
              onChanged: (val) {
                controller.setNotificationStatus();
              },
              activeColor: primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        const MenuItemDividerWidget(),
        MenuItemWidget(
          leadingIconPath: 'assets/icons/status.svg',
          label: 'O приложении',
          onTap: () {
            controller.openAboutAppPage();
          },
        ),
        const MenuItemDividerWidget(),
      ],
    );
  }

  Widget _buildExitButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: primaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.logout();
          },
          borderRadius: BorderRadius.circular(13),
          child: Container(
            width: double.infinity,
            height: 60,
            alignment: Alignment.center,
            child: Text(
              'Выйти',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: onPrimaryColor,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
