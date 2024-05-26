import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_point_dto.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DbRepository {
  final DbProvider provider;

  DbRepository(this.provider);

  Future<List<SellerDto>?> fetchSellersInsideRadius({
    required Point userLocation,
    required int radiusInKm,
  }) async {
    return await provider.fetchSellersInsideRadius(
      userLocation: userLocation,
      radiusInKm: radiusInKm,
    );
  }

  Future<List<SellerPointDto>?> fetchAllSellersPoint() async {
    return await provider.fetchAllSellersPoint();
  }

  Future<List<SellerDto>> fetchFavoriteSellers(String? userId) async {
    if (userId == null) {
      return [];
    }
    return await provider.fetchFavoriteSellers(userId);
  }

  Future<void> updateFavoriteSellers(
    List<SellerDto> favoriteSellers,
    String userId,
  ) async {
    await provider.updateFavoriteSellers(
      favoriteSellers.map((e) => e.sellerId).toList(),
      userId,
    );
  }

  Future<int?> fetchServiceFee() async {
    return await provider.fetchServiceFee();
  }

  Future<List<OrderDto>?> fetchUserOrders(String userId) async {
    return await provider.fetchUserOrders(userId);
  }

  Future<OrderDto?> fetchOrderById(String orderId) async {
    return await provider.fetchOrderById(orderId);
  }

  Future<ReviewDto?> publishReview(ReviewDto review) async {
    return await provider.publishReview(review.toMap());
  }

  Future<List<OrderDto>?> fetchActiveOrdersByUserId(String? userId) async {
    if (userId == null) {
      return null;
    }
    return await provider.fetchActiveOrdersByUserId(userId);
  }
}
