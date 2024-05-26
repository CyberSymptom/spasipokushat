import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/auth_provider.dart';
import 'package:spasipokushat/app/data/repositories/auth_repository.dart';

import 'otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(
        AuthRepository(AuthProvider()),
      ),
    );
  }
}
