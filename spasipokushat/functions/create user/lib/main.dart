import 'dart:async';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart';

Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint(Platform.environment['ENDPOINT']!)
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(Platform.environment['SECRET_KEY']);

  final Databases db = Databases(client);
  final Users users = Users(client);

  final Map<String, dynamic> body = context.req.body;

  final String userId = body[r'$id'];

  try {
    context.log('Добавления пользователя $userId в базу данных.');
    final int totalUser = await users.list().then((value) => value.total);
    await db.createDocument(
      databaseId: Platform.environment['PRODUCTION_DATABASE_ID']!,
      collectionId: Platform.environment['CLIENT_COLLECTION_ID']!,
      documentId: userId,
      data: {
        'favorites': [],
        'delivery_number': totalUser + 1,
      },
    );
    context.log('Пользователя добавлен в базу данных.');
  } on AppwriteException catch (e) {
    context.error('Произошла ошибка: ${e.message}. Код ошибки - ${e.code}');
    return context.res.empty();
  }

  try {
    context.log('Обновление пользовательских предпочтений.');

    await users.updatePrefs(
      userId: userId,
      prefs: {
        'push': true,
        'mode': 'light',
      },
    );
    context.log('Пользовательские предпочтения обновлены.');
    context.log('Пуш уведомления: true, Тема: светлая');
  } on AppwriteException catch (e) {
    context.error('Произошла ошибка: ${e.message}. Код ошибки - ${e.code}');
  }

  return context.res.empty();
}
