import 'package:appwrite/appwrite.dart';
import 'package:flutter/rendering.dart';
import 'package:spasipokushat/app/core/config/appwrite_config.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_point_dto.dart';
import 'package:spasipokushat/app/data/enums/order_status_enum.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DbProvider {
  final Databases db = Databases(AppwriteService.to.client);

  Future<List<SellerDto>?> fetchSellersInsideRadius({
    required Point userLocation,
    required int radiusInKm,
  }) async {
    final points = UtilsHelper.calculateBoundingBox(
        userLocation.latitude, userLocation.longitude, radiusInKm.toDouble());
    final db = Databases(AppwriteService.to.client);

    final req = db.listDocuments(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.sellersCollectionId,
      queries: [
        Query.equal('is_on_moderation', false),
        Query.greaterThan('package_quantity', 0),
        Query.between('lat', points[0].latitude, points[1].latitude),
        Query.between('lng', points[0].longitude, points[1].longitude),
        Query.limit(1000),
      ],
    );

    try {
      final res = await req;
      return res.convertTo(
        (doc) => SellerDto.fromDoc(doc),
      );
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<List<SellerDto>> fetchFavoriteSellers(String clientId) async {
    final req = db.getDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.clientsCollectionId,
      documentId: clientId,
    );

    try {
      final res = await req;
      final List<dynamic> rawListData = res.data['favorites'];
      final favoriteSellers =
          rawListData.map((e) => SellerDto.fromDoc(e)).toList();
      return favoriteSellers;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return [];
    }
  }

  Future<List<SellerPointDto>?> fetchAllSellersPoint() async {
    final req = db.listDocuments(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.sellersCollectionId,
      queries: [
        Query.equal('is_on_moderation', false),
        Query.greaterThan('package_quantity', 0),
        Query.select([
          r'$id',
          r'$createdAt',
          r'$updatedAt',
          r'$permissions',
          'lat',
          'lng',
        ]),
        Query.limit(100000),
      ],
    );

    try {
      final res = await req;
      debugPrint('res total: ${res.total}');
      return res.convertTo(
        (doc) => SellerPointDto.fromMap(doc),
      );
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<void> updateFavoriteSellers(
    List<String> favoriteSellers,
    String userId,
  ) async {
    final req = db.updateDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.clientsCollectionId,
      documentId: userId,
      data: {'favorites': favoriteSellers},
    );

    try {
      await req;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<int?> fetchServiceFee() async {
    final req = db.getDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.settingsCollectionId,
      documentId: 'production',
    );

    try {
      final res = await req;
      final data = res.data;
      final serviceFee = data['service_fee'];
      return serviceFee;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<List<OrderDto>?> fetchUserOrders(String userId) async {
    final req = db.getDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.clientsCollectionId,
      documentId: userId,
    );

    try {
      final res = await req;
      final List<dynamic> rawOrders = res.data['orders'];
      debugPrint(rawOrders.toString());
      final orders = rawOrders.map((e) => OrderDto.fromMap(e)).toList();
      return orders;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<OrderDto?> fetchOrderById(String orderId) async {
    final req = db.getDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.ordersCollectionId,
      documentId: orderId,
    );

    try {
      final res = await req;
      final order = res.convertTo((data) => OrderDto.fromMap(data));
      return order;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<ReviewDto?> publishReview(Map<String, dynamic> data) async {
    debugPrint('data^ $data');
    final req = db.createDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.reviewsCollectionId,
      documentId: ID.unique(),
      data: data,
    );

    try {
      final res = await req;

      final review = res.convertTo((data) => ReviewDto.fromMap(data));
      return review;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<List<OrderDto>?> fetchActiveOrdersByUserId(String? userId) async {
    if (userId == null) {
      return null;
    }

    final req = db.getDocument(
      databaseId: AppwriteConfig.productionDatabaseId,
      collectionId: AppwriteConfig.clientsCollectionId,
      documentId: userId,
    );

    List<dynamic> ordersList = [];

    try {
      final res = await req;
      ordersList = res.data['orders'] as List<dynamic>;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }

    if (ordersList.isEmpty) {
      return [];
    }

    final List<OrderDto> orders =
        ordersList.map((e) => OrderDto.fromMap(e)).toList();

    final activeOrders = orders
        .where((element) =>
            element.status == OrderStatusEnum.created ||
            element.status == OrderStatusEnum.ready)
        .toList();
    return activeOrders;
  }
}
