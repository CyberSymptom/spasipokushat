import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/core/config/appwrite_config.dart';

class AppwriteService extends GetxService {
  late Client client;

  static AppwriteService get to => Get.find();

  Future<AppwriteService> init() async {
    client = Client()
        .setEndpoint(AppwriteConfig.endpoint)
        .setProject(AppwriteConfig.projectId)
        .setLocale('ru');
    return this;
  }
}
