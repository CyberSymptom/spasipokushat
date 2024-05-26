import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'seller_quiz_form_controller.dart';

class SellerQuizFormPage extends GetView<SellerQuizFormController> {
  const SellerQuizFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: surfaceColor,
        surfaceTintColor: surfaceColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: WebViewWidget(
        controller: controller.controller,
      ),
    );
  }
}
