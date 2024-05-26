import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/config/appwrite_config.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/enums/route_enum.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:spasipokushat/app/routes/order_routes.dart';
import 'package:spasipokushat/app/routes/seller_routes.dart';

class SellerController extends GetxController with StateMixin<SellerDto> {
  late RouteEnum previousRoute;

  @override
  void onInit() {
    previousRoute = UtilsHelper.definePreviousRoute(Get.parameters);
    fetchSeller();
    super.onInit();
  }

  void fetchSeller() async {
    if (previousRoute == RouteEnum.app) {
      change(
        (Get.arguments as SellerDto),
        status: RxStatus.success(),
      );
      return;
    }
    change(null, status: RxStatus.loading());

    final String sellerId = Get.parameters['id']!;

    try {
      final doc = await Databases(AppwriteService.to.client).getDocument(
        databaseId: AppwriteConfig.productionDatabaseId,
        collectionId: AppwriteConfig.sellersCollectionId,
        documentId: sellerId,
      );

      final seller = SellerDto.fromDoc(doc.data);
      change(seller, status: RxStatus.success());
    } on AppwriteException catch (e) {
      change(null, status: RxStatus.error());
      debugPrint(
        'Error getting seller from appWirte.\n '
        'Appwrite error message: ${e.message}',
      );
    }
  }

  void openReviewsPage(SellerDto seller) {
    Get.toNamed(
      SellerRoutes.reviews,
      arguments: seller,
    );
  }

  void openAboutPage(SellerDto seller) {
    Get.toNamed(
      SellerRoutes.about,
      arguments: seller,
    );
  }

  void openOrderPage(SellerDto seller) {
    Get.toNamed(
      OrderRoutes.order,
      arguments: seller,
    );
  }
}
