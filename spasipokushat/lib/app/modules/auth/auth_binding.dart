import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/auth_provider.dart';
import 'package:spasipokushat/app/data/repositories/auth_repository.dart';

import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        AuthRepository(AuthProvider()),
      ),
    );
  }
}
