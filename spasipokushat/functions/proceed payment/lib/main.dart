import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

// This is your Appwrite function
// It's executed each time we get a request
Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint(Platform.environment['ENDPOINT']!)
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(Platform.environment['SECRET_KEY']);

  final Databases db = Databases(client);

  final Map<dynamic, dynamic> body = json.decode(context.req.body);

  final status = await createOrder(db, body, context);

  if (status == null) {
    return context.res.empty();
  }
  await updateProductQuantity(db, body['order']['seller'], context);

  await updateOrderStatus(db, status, context);

  // `res.json()` is a handy helper for sending JSON
  return context.res.empty();
}

Future<String?> createOrder(
    Databases db, Map<dynamic, dynamic> body, context) async {
  final order = body['order'];
  final orderNumber = await getOrderNumber(order['client'], db);
  context.log('Order number: $orderNumber');

  final req = db.createDocument(
    databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
    collectionId: Platform.environment['ORDERS_COLLECTION_ID']!,
    documentId: ID.unique(),
    data: {
      'item': order['item'],
      'service_fee': order['service_fee'],
      'status': 'Создан',
      'seller': order['seller'],
      'price': order['price'],
      'client': order['client'],
      'order_number': orderNumber,
    },
  );

  try {
    final res = await req;
    context.log('Заказ ${res.$id} создан в базе данных');
    return res.$id;
  } on AppwriteException catch (e) {
    context.log(e.toString());
    return null;
  }
}

Future<void> updateOrderStatus(Databases db, String orderId, context) async {
  final req = db.updateDocument(
    databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
    collectionId: Platform.environment['ORDERS_COLLECTION_ID']!,
    documentId: orderId,
    data: {
      'status': 'Оформлен',
    },
  );

  try {
    final res = await req;
    context.log('Заказ $orderId переведен в статус: Оформлен');
  } on AppwriteException catch (e) {
    context.log(e.toString());
  }
}

Future<void> updateProductQuantity(
    Databases db, String sellerId, context) async {
  final sellerReq = db.getDocument(
    databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
    collectionId: Platform.environment['SELLER_COLLECTION_ID']!,
    documentId: sellerId,
  );

  Document sellerRes;

  try {
    sellerRes = await sellerReq;
  } on AppwriteException catch (e) {
    context.log(e.toString());
    return;
  }

  final int productQuantity = sellerRes.data['package_quantity'];

  if (productQuantity == 0) {
    return;
  }

  try {
    await db.updateDocument(
      databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
      collectionId: Platform.environment['SELLER_COLLECTION_ID']!,
      documentId: sellerId,
      data: {
        'package_quantity': productQuantity - 1,
      },
    );
    context.log(
      'Количество свободный блюд у продавца $sellerId обновлено. '
      'На данный момент свободно ${productQuantity - 1} позиций',
    );
  } on AppwriteException catch (e) {
    context.log(e.toString());
    return;
  }
}

Future<String> getOrderNumber(
  String userId,
  Databases db,
) async {
  final req = db.getDocument(
    databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
    collectionId: Platform.environment['CLIENT_COLLECTION_ID']!,
    documentId: userId,
  );

  final res = await req;
  final data = res.data;

  final int deliveryNumber = data['delivery_number'];
  final orders = data['orders'];

  final String orderNumber = '$deliveryNumber-${orders.length + 1}';
  return orderNumber;
}
