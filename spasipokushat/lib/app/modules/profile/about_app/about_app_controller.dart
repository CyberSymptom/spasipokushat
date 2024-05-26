import 'package:get/get.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/routes/profile_routes.dart';

class AboutAppController extends GetxController {
  void openPrivacyPolicyPage() {
    UtilsHelper.openUrl('https://google.com'); //TODO: change url
  }

  void openUserAgreementPage() {
    UtilsHelper.openUrl('https://google.com'); //TODO: change url
  }

  void openAppVersionPage() {
    Get.toNamed(
      ProfileRoutes.appVersion,
    );
  }
}
