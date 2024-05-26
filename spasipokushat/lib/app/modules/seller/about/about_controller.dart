import 'package:get/get.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';

class AboutController extends GetxController {
  final seller = Get.arguments as SellerDto;

  void openSellerOnMap() {
    UtilsHelper.openYandexMap(
      seller.point.latitude,
      seller.point.longitude,
    );
  }
}
