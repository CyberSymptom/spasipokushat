import 'package:get/get.dart';

import '../modules/seller_quiz_form/seller_quiz_form_binding.dart';
import '../modules/seller_quiz_form/seller_quiz_form_page.dart';

class SellerQuizFormRoutes {
  SellerQuizFormRoutes._();

  static const sellerQuizForm = '/seller-quiz-form';

  static final routes = [
    GetPage(
      name: sellerQuizForm,
      page: () => const SellerQuizFormPage(),
      binding: SellerQuizFormBinding(),
    ),
  ];
}
