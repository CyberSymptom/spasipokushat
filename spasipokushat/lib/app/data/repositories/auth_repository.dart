import 'package:appwrite/models.dart';
import 'package:spasipokushat/app/data/providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider api;
  AuthRepository(this.api);

  Future<Token?> sendOtpCode(String phone) async {
    return await api.sendOtpCode(phone);
  }

  Future<Session?> verifyOtpCode({
    required String otp,
    required String userId,
  }) async {
    return await api.verifyOtpCode(otp: otp, userId: userId);
  }
}
