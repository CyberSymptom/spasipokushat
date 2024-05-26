import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';

// This is your Appwrite function
// It's executed each time we get a request
Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint(Platform.environment['ENDPOINT']!)
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(Platform.environment['SECRET_KEY']);

  final db = Databases(client);

  final Map<String, dynamic> body = context.req.body;

  final int rate = body['rate'];

  final String sellerId = body['seller'][r'$id'];

  final seller = await db.getDocument(
    databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
    collectionId: Platform.environment['SELLER_COLLECTION_ID']!,
    documentId: sellerId,
  );

  final sellerData = seller.data;

  final double currentRate = double.parse(sellerData['rating']);

  final int reviewsQuantity = sellerData['reviews'].length;

  final String updatedRes = calculateRating(currentRate, reviewsQuantity, rate);

  await db.updateDocument(
      databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
      collectionId: Platform.environment['SELLER_COLLECTION_ID']!,
      documentId: sellerId,
      data: {
        'rating': updatedRes,
      });
  context.log('Рейтинг продавца $sellerId обновлен '
      'с $currentRate до $updatedRes');

  return context.res.empty();
}

String calculateRating(double currentRating, int reviewsQuantity, int rate) {
  final totalRating = currentRating * (reviewsQuantity - 1);

  final res = (totalRating + rate) / reviewsQuantity;
  return res.toStringAsFixed(1);
}
