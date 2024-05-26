import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';
import 'package:spasipokushat/app/routes/profile_routes.dart';
import 'package:spasipokushat/app/routes/seller_quiz_form_routes.dart';

import 'widgets/widgets.dart';

class ProfileController extends GetxController {
  final RxBool isUserAuthenticated = true.obs;
  final RxString userName = 'Как вас зовут?'.obs;
  final RxString userPhone = '+7 (999) 999-99-99'.obs;
  final notificationStatus = false.obs;

  late TextEditingController nameController;

  @override
  void onInit() {
    initUserInfo(UserService.to.user.value);
    listenToUserChanges();

    nameController = TextEditingController(
      text: isUserNameSet ? userName.value : null,
    );
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void initUserInfo(User? user) {
    if (user == null) {
      debugPrint('Пользователь не авторизован');
      isUserAuthenticated.value = false;
      return;
    }
    isUserAuthenticated.value = true;
    if (user.name.isNotEmpty) {
      userName.value = user.name;
    }
    userPhone.value = user.phone;

    notificationStatus.value = user.prefs.data['push'] ?? false;
  }

  void listenToUserChanges() {
    ever(
      UserService.to.user,
      (callback) {
        initUserInfo(callback);
      },
    );
  }

  void showSetNameBottomSheet() {
    Get.bottomSheet(
      const SetNameBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  void logout() async {
    await Account(AppwriteService.to.client)
        .deleteSession(sessionId: 'current');
    Get.find<HomeController>().fetch();
    await UserService.to.initUser(demo: false);
  }

  void deleteProfile() async {
    await Account(AppwriteService.to.client)
        .deleteSession(sessionId: 'current');
    Get.find<HomeController>().fetch();
    await UserService.to.initUser(demo: false);
  }

  void becomeSeller() async {
    Get.toNamed(SellerQuizFormRoutes.sellerQuizForm);
  }

  void openAboutAppPage() {
    Get.toNamed(
      ProfileRoutes.aboutApp,
    );
  }

  void openOrdersHistoryPage() {
    Get.toNamed(ProfileRoutes.ordersHistory);
  }

  void setNotificationStatus() async {
    notificationStatus.toggle();
    final status = await UserService.to.updateUserPrefs(
      push: notificationStatus.value,
    );
    if (!status) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Произошла ошибка',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void setName() async {
    String name = nameController.text;
    name.trim();
    name = GetUtils.capitalizeFirst(name)!;
    FocusManager.instance.primaryFocus!.unfocus();
    Get.back();

    if (name.isEmpty) {
      return;
    }

    final bool status = await UserService.to.updateName(name);

    if (!status) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Имя не обновлено, попробуйте еще раз',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool get isUserNameSet {
    if (userName.value.isEmpty || userName.value == 'Как вас зовут?') {
      return false;
    }
    return true;
  }
}
