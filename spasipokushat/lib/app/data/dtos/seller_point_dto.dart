class SellerPointDto {
  final String id;
  final double latitude;
  final double longitude;

  SellerPointDto({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  factory SellerPointDto.fromMap(Map<dynamic, dynamic> data) {
    return SellerPointDto(
      id: data['\$id'],
      latitude: data['lat'],
      longitude: data['lng'],
    );
  }
}
