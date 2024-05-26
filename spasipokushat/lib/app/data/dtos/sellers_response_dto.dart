import 'package:get/get.dart';
import 'package:spasipokushat/app/data/dtos/order_dto.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';

class SellersResponseDto {
  final List<SellerDto> recomended;
  final List<SellerDto> newPlaces;
  final RxList<SellerDto> favorites;
  OrderDto? activeOrder;

  SellersResponseDto({
    required this.recomended,
    required this.newPlaces,
    required this.favorites,
    required this.activeOrder,
  });
}
