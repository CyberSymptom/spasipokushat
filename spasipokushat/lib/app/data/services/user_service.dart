import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/data/extensions/address_extension.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as mapkit;

import '../../core/config/consts.dart';

class UserService extends GetxService {
  final Account account = Account(AppwriteService.to.client);

  final YandexGeocoder geocoder = YandexGeocoder(
    apiKey: '4873afbb-fcc2-4bc3-bbc8-5ee3b03c68e8',
  );

  static UserService get to => Get.find();

  late Worker userPositionWorker;
  late Rxn<User> user;
  late bool isFirstOpen;

  final userPosition = Rx<mapkit.Point>(defaultPosition);
  final userAddress = ''.obs;
  final userCity = 'Москва'.obs;
  final searchRadius = 10.obs;

  Future<UserService> init({bool demo = false}) async {
    await initUser(demo: demo);
    await initPosition();
    await GetStorage.init('userContainer');
    return this;
  }

  @override
  void onInit() {
    userPositionWorker = once(
      userPosition,
      (callback) async {
        await updateUserAddress();
      },
      condition: () => userPosition.value != defaultPosition,
      onDone: () => userPositionWorker.dispose(),
    );

    ever(
      userPosition,
      (callback) async => await updageUserCity(),
      condition: userAddress.value.isNotEmpty,
    );
    super.onInit();
  }

  Future<void> updateUserAddress() async {
    final address = await getAddressByCoordinates(
      lat: userPosition.value.latitude,
      lng: userPosition.value.longitude,
    );
    if (address == null) {
      return;
    }
    userAddress.value = address.toReadableAddress();

    final String city = address.components!
        .firstWhere((element) => element.kind == KindResponse.locality)
        .name!;

    userCity.value = GetUtils.capitalizeFirst(city)!;
  }

  Future<void> updageUserCity() async {
    final address = await getAddressByCoordinates(
      lat: userPosition.value.latitude,
      lng: userPosition.value.longitude,
    );

    final String city = address!.components!
        .firstWhere((element) => element.kind == KindResponse.locality)
        .name!;

    userCity.value = GetUtils.capitalizeFirst(city)!;
  }

  Future<void> initUser({required bool demo}) async {
    if (demo) {
      user = Rxn<User>(User(
        $id: '65906fef38fdf2fb10dd',
        $createdAt: DateTime(2022, 01, 01).toIso8601String(),
        $updatedAt: DateTime(2022, 01, 03).toIso8601String(),
        name: 'Демо аккаунт',
        registration: DateTime(2022, 01, 01).toIso8601String(),
        status: true,
        labels: [],
        passwordUpdate: DateTime(2023, 01, 01).toIso8601String(),
        email: '',
        phone: '+79164164179',
        emailVerification: false,
        phoneVerification: true,
        prefs: Preferences(data: {
          'push': true,
          'mode': 'light',
        }),
        accessedAt: DateTime.now().toIso8601String(),
      ));
      return;
    }
    try {
      final res = await account.get();
      user = Rxn<User>(res);
    } on AppwriteException {
      user = Rxn<User>(null);
    }
  }

  Future<void> initPosition() async {
    final bool hasPermission =
        await UtilsHelper.hasGeoLocationPermissionGranted;
    if (!hasPermission) {
      return;
    }
    final position = await UtilsHelper.requestGeolocation();
    if (position == null) {
      return;
    }
    userPosition.value = mapkit.Point(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    await updateUserAddress();
  }

  Future<Address?> getAddressByCoordinates({
    required double lat,
    required double lng,
  }) async {
    try {
      final GeocodeResponse geocodeFromPoint = await geocoder.getGeocode(
        ReverseGeocodeRequest(
          pointGeocode: (lat: lat, lon: lng),
          lang: Lang.ru,
        ),
      );
      return geocodeFromPoint.firstAddress;
    } catch (e) {
      return null;
    }
  }

  void updateUserAddressAndPosition(mapkit.Point point, String address) {
    userPosition.value = point;
    userAddress.value = address;
  }

  void updateSearchRadius(int value) => searchRadius.value = value;

  Future<bool> updateUserPrefs(
      {required bool push, String themeMode = 'light'}) async {
    try {
      Map<String, dynamic> prefs;

      prefs = {
        'push': push,
        'mode': themeMode,
      };
      user.value = await account.updatePrefs(prefs: prefs);
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  Future<bool> updateName(String name) async {
    if (user.value != null && user.value!.name == name) {
      return true;
    }
    try {
      final res = await account.updateName(name: name);
      user.value = res;
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  bool get isFirstAppOpen {
    final userContainer = GetStorage('userContainer');
    if (userContainer.hasData('isFirstAppOpen')) {
      return false;
    }
    return true;
  }

  Future<void> saveFirstAppOpen() async {
    final userContainer = GetStorage('userContainer');
    await userContainer.write('isFirstAppOpen', true);
  }
}
