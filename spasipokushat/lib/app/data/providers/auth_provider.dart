import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/rendering.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';

class AuthProvider {
  final Account account = Account(AppwriteService.to.client);

  Future<Token?> sendOtpCode(String phone) async {
    try {
      return await account.createPhoneSession(
        userId: ID.unique(),
        phone: phone,
      );
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<Session?> verifyOtpCode({
    required String otp,
    required String userId,
  }) async {
    try {
      return await account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
