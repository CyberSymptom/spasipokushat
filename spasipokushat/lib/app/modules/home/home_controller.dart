import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/config/appwrite_config.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/dtos/sellers_response_dto.dart';
import 'package:spasipokushat/app/data/enums/order_status_enum.dart';
import 'package:spasipokushat/app/data/enums/route_enum.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/routes/auth_routes.dart';
import 'package:spasipokushat/app/routes/profile_routes.dart';
import 'package:spasipokushat/app/routes/seller_routes.dart';
import 'package:spasipokushat/app/routes/sellers_list_routes.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'widgets/widgets.dart';

class HomeController extends GetxController
    with StateMixin<SellersResponseDto> {
  HomeController(this.repository);
  final DbRepository repository;

  int selectedIndex = 0;
  RealtimeSubscription? activeOrderSubscription;

  @override
  void onInit() {
    fetch();

    everAll(
      [
        UserService.to.searchRadius,
        UserService.to.userPosition,
      ],
      (callback) => fetch(),
      condition: UserService.to.userCity.value.isNotEmpty,
    );
    super.onInit();
  }

  @override
  void onReady() {
    requestGeoPermission();

    super.onReady();
  }

  void changePage(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onClose() {
    activeOrderSubscription?.close();
    super.onClose();
  }

  void requestGeoPermission() async {
    final position = await UtilsHelper.requestGeolocation();

    if (position == null) return;

    UserService.to.userPosition.value = Point(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  void showRadiusSelectionBottomSheet() {
    Get.bottomSheet(
      const RadiusSelectionBottomSheet(),
      backgroundColor: const Color(0xffFCFCFC),
      elevation: 0,
    );
  }

  void openSellerPage(SellerDto sellerDto) {
    Get.toNamed(
      SellerRoutes.seller,
      arguments: sellerDto,
      parameters: {
        'id': sellerDto.sellerId,
        'route': RouteEnum.app.name,
      },
    );
  }

  void openSellersListPage(
    List<SellerDto> sellers,
    String title,
  ) {
    Get.toNamed(
      SellersListRoutes.sellersList,
      arguments: sellers,
      parameters: {'title': title},
    );
  }

  void fetch() async {
    change(null, status: RxStatus.loading());

    final Future req = Future.wait([
      repository.fetchSellersInsideRadius(
        userLocation: UserService.to.userPosition.value,
        radiusInKm: UserService.to.searchRadius.value,
      ),
      repository.fetchFavoriteSellers(UserService.to.user.value?.$id),
      repository.fetchActiveOrdersByUserId(UserService.to.user.value?.$id),
    ]);

    final futureRes = await req;

    final List<SellerDto>? allSellers = futureRes[0];

    final List<SellerDto> favoriteSellers = futureRes[1];

    final List<OrderDto>? activeOrders = futureRes[2];

    final OrderDto? activeOrder = activeOrders == null
        ? null
        : activeOrders.isEmpty
            ? null
            : activeOrders.last;

    if (allSellers == null) {
      change(null, status: RxStatus.error());
      return;
    }
    if (allSellers.isEmpty) {
      change(null, status: RxStatus.empty());
      return;
    }

    if (activeOrder != null) {
      listenToActiveOrderChanges(activeOrder.id!);
    }

    final res = SellersResponseDto(
      recomended: allSellers,
      newPlaces: allSellers.reversed.toList(),
      favorites: favoriteSellers.obs,
      activeOrder: activeOrder,
    );
    change(res, status: RxStatus.success());
  }

  bool isSellerFavorite(SellerDto seller) {
    final favorites = state!.favorites;

    if (favorites.isEmpty) {
      return false;
    }
    if (!favorites.contains(seller)) {
      return false;
    }
    return true;
  }

  void fetchActiveOrder() async {
    final activeOrders = await repository.fetchActiveOrdersByUserId(
      UserService.to.user.value?.$id,
    );

    if (activeOrders == null) {
      activeOrderSubscription?.close();
      return;
    }
    if (activeOrders.isEmpty) {
      state!.activeOrder = null;
      activeOrderSubscription?.close();
      change(state, status: RxStatus.success());
      return;
    }
    state!.activeOrder = activeOrders.last;

    change(state, status: RxStatus.success());
    listenToActiveOrderChanges(state!.activeOrder!.id!);
  }

  void listenToActiveOrderChanges(String orderId) {
    activeOrderSubscription = Realtime(AppwriteService.to.client).subscribe([
      'databases.${AppwriteConfig.productionDatabaseId}.'
          'collections.${AppwriteConfig.ordersCollectionId}.documents.$orderId'
    ]);

    activeOrderSubscription!.stream.listen((event) {
      final activeOrder = OrderDto.fromMap(event.payload);
      if (activeOrder.status == OrderStatusEnum.canceled ||
          activeOrder.status == OrderStatusEnum.picked) {
        state!.activeOrder = null;
        change(state, status: RxStatus.success());
        activeOrderSubscription!.close();
        return;
      }
      state!.activeOrder = activeOrder;
      change(state, status: RxStatus.success());
    });
  }

  void removeFromFavorite(SellerDto seller) async {
    state!.favorites.remove(seller);
    change(state, status: RxStatus.success());
    await repository.updateFavoriteSellers(
      state!.favorites,
      UserService.to.user.value!.$id,
    );
  }

  void addSellerToFavorite(SellerDto seller) async {
    if (UserService.to.user.value == null) {
      Get.toNamed(AuthRoutes.auth);
      return;
    }
    state!.favorites.add(seller);
    change(state, status: RxStatus.success());
    await repository.updateFavoriteSellers(
      state!.favorites,
      UserService.to.user.value!.$id,
    );
  }

  void openOrderDetails() {
    Get.toNamed(
      ProfileRoutes.orderDetails,
      parameters: {'id': state!.activeOrder!.id!},
      arguments: state!.activeOrder,
    );
  }
}
