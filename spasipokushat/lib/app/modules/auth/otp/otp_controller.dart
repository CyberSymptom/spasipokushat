import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/widgets/loader.dart';
import 'package:spasipokushat/app/data/repositories/auth_repository.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/modules/profile/profile_controller.dart';

class OtpController extends GetxController {
  OtpController(this.repository);
  final AuthRepository repository;

  late TextEditingController pinController;
  late String userId;
  late String phone;
  RxBool canResendOtp = false.obs;
  RxInt secondsRemaining = 60.obs;
  late Timer _timer;

  final demoOtp = '000000';

  @override
  void onInit() {
    pinController = TextEditingController();
    userId = Get.parameters['userId']!;
    phone = Get.parameters['phone']!;
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    stopTimer();
  }

  void startTimer() {
    canResendOtp.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        resetTimer();
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void resetTimer() {
    stopTimer();
    canResendOtp.value = true;
    secondsRemaining.value = 60;
  }

  void changePhoneNubmer() {
    FocusManager.instance.primaryFocus!.unfocus();
    Get.back(result: true);
  }

  void resendOtp() async {
    final status = await Get.showOverlay<Token?>(
      asyncFunction: () async {
        return await repository.sendOtpCode(phone);
      },
      loadingWidget: const Loader(),
    );
    if (status == null) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Произошла ошибка, попробуйте еще раз',
      ));

      return;
    }
    userId = status.userId;
    startTimer();
  }

  void completeOtpVerification(String otp) async {
    if (otp == demoOtp) {
      await UserService.to.initUser(demo: true);
      FocusManager.instance.primaryFocus!.unfocus();
      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().initUserInfo(UserService.to.user.value);
      }
      Get.close(2);

      return;
    }
    final status = await Get.showOverlay<Session?>(
      asyncFunction: () async {
        try {
          return await repository.verifyOtpCode(otp: otp, userId: userId);
        } on AppwriteException catch (e) {
          debugPrint(e.message);
          return null;
        }
      },
      loadingWidget: const Loader(),
    );
    if (status == null) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Произошла ошибка или введен неверный код',
          duration: Duration(seconds: 2),
        ),
      );
      pinController.clear();
      return;
    }

    final hasUser = await Get.showOverlay<bool>(
      asyncFunction: () async {
        await UserService.to.initUser(demo: false);
        if (UserService.to.user.value == null) {
          return false;
        }
        return true;
      },
      loadingWidget: const Loader(),
    );

    if (!hasUser) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Произошла ошибка, попробуйте еще раз',
          duration: Duration(seconds: 2),
        ),
      );
      pinController.clear();
      return;
    }
    FocusManager.instance.primaryFocus!.unfocus();
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().initUserInfo(UserService.to.user.value);
    }
    Get.close(2);
  }
}
