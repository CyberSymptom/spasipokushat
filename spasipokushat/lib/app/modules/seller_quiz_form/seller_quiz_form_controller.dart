import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SellerQuizFormController extends GetxController {
  late WebViewController controller;

  @override
  void onInit() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
    super.onInit();
  }

  @override
  void onReady() {
    startWebView();
    super.onReady();
  }

  void startWebView() async {
    await controller.loadRequest(
      Uri.parse('https://forms.yandex.ru/u/659603155056909ef585530b/'),
    );
  }
}
