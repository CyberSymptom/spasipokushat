import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';
import 'widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (_) {
        return buildBody();
      },
    );
  }

  Widget buildBody() {
    return GetX<ProfileController>(
      builder: (controller) {
        if (!controller.isUserAuthenticated.value) {
          return const GuestProfileWidget();
        }
        return const UserProfileWidget();
      },
    );
  }
}
