import 'package:spasipokushat/app/data/dtos/review_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/dtos/user_dto.dart';
import 'package:spasipokushat/app/data/enums/order_status_enum.dart';

class OrderDto {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String orderNumber;
  final OrderStatusEnum status;
  final String item;
  final int price;
  final int serviceFee;
  final ReviewDto? review;
  final UserDto? user;
  final SellerDto seller;

  OrderDto({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.orderNumber,
    required this.item,
    required this.price,
    required this.serviceFee,
    required this.status,
    this.review,
    this.user,
    required this.seller,
  });

  factory OrderDto.fromMap(Map<dynamic, dynamic> data) {
    final Map<dynamic, dynamic>? reviewData = data['review'];
    return OrderDto(
      id: data[r'$id'],
      createdAt: DateTime.parse(data[r'$createdAt']),
      updatedAt: DateTime.parse(data[r'$updatedAt']),
      orderNumber: data['order_number'],
      item: data['item'],
      price: data['price'],
      serviceFee: data['service_fee'],
      status: OrderStatusEnum.fromValue(data['status']),
      seller: SellerDto.fromDoc(data['seller']),
      review: reviewData == null ? null : ReviewDto.fromMap(reviewData),
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'order_number': orderNumber,
      'item': item,
      'price': price,
      'service_fee': serviceFee,
      'status': status.value,
      'review': [],
      'client': [
        userId,
      ],
      'seller': [
        seller.sellerId,
      ],
    };
  }

  set orderNumber(String value) => orderNumber = value;
}
