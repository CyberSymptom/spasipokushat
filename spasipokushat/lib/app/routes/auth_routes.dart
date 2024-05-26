import 'package:get/get.dart';

import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_page.dart';
import '../modules/auth/otp/otp_binding.dart';
import '../modules/auth/otp/otp_page.dart';

class AuthRoutes {
  AuthRoutes._();

  static const auth = '/auth';
	static const otp = '/auth/otp';

  static final routes = [
    GetPage(
      name: auth,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),
		GetPage(
      name: otp,
      page: () => const OtpPage(),
      binding: OtpBinding(),
    ),
  ];
}
