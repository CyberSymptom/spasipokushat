import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:equatable/equatable.dart';

class SellerDto extends Equatable {
  final String sellerId;
  final String youkassaShopId;
  final String name;
  final String thumbnailUrl;
  final String? logoUrl;
  final String productName;
  final String productDescription;
  final int regularPrice;
  final int? salePrice;
  final int productQuantity;
  final String rating;
  final List<String> pickupTime;
  final String pickupAddress;
  final Point point;
  final List<ReviewDto> reviews;
  final String? website;
  final String phone;

  const SellerDto({
    required this.name,
    required this.youkassaShopId,
    required this.thumbnailUrl,
    this.logoUrl,
    required this.productName,
    required this.productDescription,
    required this.regularPrice,
    required this.salePrice,
    required this.productQuantity,
    required this.rating,
    required this.sellerId,
    required this.pickupTime,
    required this.pickupAddress,
    required this.point,
    required this.reviews,
    required this.website,
    required this.phone,
  });

  factory SellerDto.fromDoc(Map<dynamic, dynamic> data) {
    final List<dynamic> rawPickupTime = data['pickup_time'];
    final List<dynamic>? reviews = data['reviews'];

    return SellerDto(
      name: data['name'],
      thumbnailUrl: data['thumbnail'],
      youkassaShopId: data['yookassa_shop_id'],
      logoUrl: data['logo'],
      productName: data['package_name'],
      productDescription: data['package_description'],
      regularPrice: data['regular_price'],
      salePrice: data['sale_price'],
      productQuantity: data['package_quantity'],
      rating: data['rating'],
      pickupTime: rawPickupTime.map((e) => e as String).toList(),
      pickupAddress: data['address'],
      point: Point(
        latitude: data['lat'],
        longitude: data['lng'],
      ),
      sellerId: data['\$id'],
      reviews: reviews == null
          ? []
          : reviews.map((e) => ReviewDto.fromMap(e)).toList(),
      phone: data['phone'],
      website: data['website'],
    );
  }

  int get finalPrice {
    if (salePrice != null) {
      return salePrice!;
    }
    return regularPrice;
  }

  @override
  List<Object?> get props => [sellerId];
}
