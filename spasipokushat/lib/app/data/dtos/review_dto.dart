class ReviewDto {
  final String? id;
  final String? name;
  final String? review;
  final DateTime? createdAt;
  final int rate;
  final String? order;
  final String? seller;

  ReviewDto({
    this.id,
    this.name,
    required this.review,
    this.createdAt,
    required this.rate,
    this.order,
    this.seller,
  });

  factory ReviewDto.fromMap(Map<dynamic, dynamic> data) {
    return ReviewDto(
      id: data['\$id'],
      name: data['created_by'],
      review: data['text'],
      createdAt: DateTime.parse(data['\$createdAt']),
      rate: data['rate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_by': name,
      'text': review,
      'rate': rate,
      'seller': seller!,
      'order': order!,
    };
  }
}
