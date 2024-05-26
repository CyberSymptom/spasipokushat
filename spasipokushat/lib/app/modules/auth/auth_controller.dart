import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:spasipokushat/app/core/widgets/loader.dart';
import 'package:spasipokushat/app/data/repositories/auth_repository.dart';
import 'package:spasipokushat/app/modules/auth/otp/otp_page.dart';
import 'package:spasipokushat/app/modules/auth/otp/otp_pages.dart';

import 'package:spasipokushat/app/routes/auth_routes.dart';

class AuthController extends GetxController {
  AuthController(this.repository);
  final AuthRepository repository;

  late TextEditingController phoneController;
  late FocusNode phoneNode;

  var maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final String demoPhoneNumber = '+79164164179';

  @override
  void onInit() {
    phoneController = TextEditingController(text: '+7');
    phoneNode = FocusNode();
    super.onInit();
  }
    void toOtp(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(),),);

    }
  @override
  void onClose() {
    phoneController.dispose();
    phoneNode.dispose();
    super.onClose();
  }

  void sendOtpCode() async {
    final String phone = '+7${maskFormatter.getUnmaskedText()}';

    Token? token;

    if (phone == demoPhoneNumber) {
      token = Token(
        $id: 'token_id',
        $createdAt: DateTime(2023, 12, 06).toIso8601String(),
        userId: '65906fef38fdf2fb10dd',
        secret: 'secret',
        expire:
            DateTime.now().add(const Duration(minutes: 60)).toIso8601String(),
      );
    } else {
      token = await Get.showOverlay<Token?>(
        asyncFunction: () async {
          return await repository.sendOtpCode(phone);
        },
        loadingWidget: const Loader(),
      );
    }

    if (token != null) {
      toOtp;
      return;
    }

    await Get.toNamed(
      AuthRoutes.otp,
      parameters: {
        'userId': token!.userId,
        'phone': phone,
      },
    );
  }
}
