import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/routes/home_routes.dart';
import 'package:spasipokushat/app/routes/seller_quiz_form_routes.dart';

class OnboardingController extends GetxController {
  @override
  void onReady() {
    UserService.to.saveFirstAppOpen();
    super.onReady();
  }

  void openHomePage() async {
    await requestPermissions();
    Get.toNamed(HomeRoutes.home);
  }

  void openSellerSignPage() async {
    await requestPermissions();
    Get.toNamed(SellerQuizFormRoutes.sellerQuizForm);
  }

  Future requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.appTrackingTransparency,
    ].request();
  }
}
