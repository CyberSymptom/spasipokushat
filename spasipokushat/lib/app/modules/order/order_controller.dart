import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwriteModels;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';
import 'package:yookassa_payments_flutter/yookassa_payments_flutter.dart';

import '../../core/widgets/loader.dart';

class OrderController extends GetxController {
  OrderController(this.repository);
  final DbRepository repository;

  late Worker errorsWorker;

  final serviceFee = 45.obs;
  final isFetching = false.obs;
  final hasErrorFetching = false.obs;

  @override
  void onInit() {
    listenForError();
    fetchServiceFee();

    super.onInit();
  }

  @override
  void onClose() {
    errorsWorker.dispose();
    super.onClose();
  }

  void fetchServiceFee() async {
    isFetching.value = true;

    final res = await repository.fetchServiceFee();
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 2));
    }

    if (res == null) {
      hasErrorFetching.value = true;

      return;
    }

    serviceFee.value = res;
    isFetching.value = false;
  }

  void listenForError() {
    errorsWorker = ever(
      hasErrorFetching,
      (callback) => Get.showSnackbar(
        const GetSnackBar(
          message: 'Произошла ошибка, проверьте '
              'соединение с интернетом',
          duration: Duration(seconds: 2),
        ),
      ),
      condition: hasErrorFetching.isTrue,
    );
  }

  void pay() async {
    final seller = Get.arguments as SellerDto;
    final String amountValue =
        (seller.finalPrice + serviceFee.value).toStringAsFixed(1);

    var clientApplicationKey = "<Ключ для клиентских приложений>";
    var amount = Amount(value: amountValue, currency: Currency.rub);

    var data = TokenizationModuleInputData(
      clientApplicationKey: clientApplicationKey,
      testModeSettings: TestModeSettings(
        true,
        3,
        amount,
        false,
      ),
      title: seller.productName,
      subtitle: seller.productName,
      amount: amount,
      shopId: seller.youkassaShopId,
      savePaymentMethod: SavePaymentMethod.on,
      tokenizationSettings: const TokenizationSettings(
        PaymentMethodTypes.bankCard,
      ),
      userPhoneNumber: UserService.to.user.value?.phone,
      customerId: UserService.to.user.value?.$id,
    );

    final res = await YookassaPaymentsFlutter.tokenization(data);

    if (res is SuccessTokenizationResult) {
      res.token;
      final status = await createPayment(res, seller);

      if (status) {
        Get.close(2);
        Get.find<HomeController>().fetchActiveOrder();
      }
    } else {
      debugPrint('not good');
    }
  }

  Future<bool> createPayment(
    SuccessTokenizationResult tokenResult,
    SellerDto seller,
  ) async {
    final data = {
      "token": tokenResult.token,
      "shopId": seller.youkassaShopId,
      "order": {
        "item": seller.productName,
        "price": seller.finalPrice,
        "service_fee": serviceFee.value,
        "seller": seller.sellerId,
        "client": UserService.to.user.value!.$id,
      }
    };
    final res = await Get.showOverlay<appwriteModels.Execution>(
      loadingWidget: const Loader(),
      asyncFunction: () async {
        final execution =
            await Functions(AppwriteService.to.client).createExecution(
          functionId: '6595cf07c66abe438db5',
          body: json.encode(data),
        );
        return execution;
      },
    );
    if (res.responseStatusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
