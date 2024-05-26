import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spasipokushat/app/core/helpers/utils_helper.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class UserAddressController extends GetxController {
  late YandexMapController mapController;
  late TextEditingController addressController;
  late PanelController panelController;
  late FocusNode addressFocusNode;
  late Worker initialFetchAddressWorker;

  final searchQuery = ''.obs;
  final suggestions = <SuggestItem>[].obs;
  final placemarks = <MapObject>[].obs;

  final isCollapsed = true.obs;
  final isFetching = false.obs;

  @override
  void onInit() {
    addressController = TextEditingController(text: initialAddress);
    panelController = PanelController();
    addressFocusNode = FocusNode();

    listenForSearchResults();

    initialFetchAddressWorker = once(
      isCollapsed,
      (callback) => initialFetchAddress(),
      condition: () => isCollapsed.isFalse,
      onDone: () => initialFetchAddressWorker.dispose(),
    );
    super.onInit();
  }

  @override
  void onClose() {
    addressController.dispose();
    addressFocusNode.dispose();
    super.onClose();
  }

  String get initialAddress {
    final userAddress = UserService.to.userAddress.value;
    if (userAddress == 'Введите Ваш адрес' || userAddress.isEmpty) {
      return '';
    }
    return userAddress;
  }

  Future<void> moveCameraToUserPosition() async {
    if (!await UtilsHelper.hasGeoLocationPermissionGranted) {
      return;
    }

    final userPosition = UserService.to.userPosition.value;

    final userPoint = Point(
      latitude: userPosition.latitude,
      longitude: userPosition.longitude,
    );

    addPositionPlacemark(userPoint);

    CameraPosition? geoposition = CameraPosition(
      target: userPoint,
      zoom: 16,
    );

    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: geoposition.target),
      ),
      animation: const MapAnimation(),
    );
  }

  void listenForSearchResults() async {
    debounce(
      searchQuery,
      (callback) {
        if (callback.isEmpty) return;
        getAddressSuggestions(searchQuery.value);
      },
      time: const Duration(milliseconds: 800),
    );
  }

  Future<void> getAddressSuggestions(String query) async {
    Point? userPoint;
    isFetching.value = true;
    final region = await mapController.getVisibleRegion();

    final uP = UserService.to.userPosition.value;
    userPoint = Point(latitude: uP.latitude, longitude: uP.longitude);

    final res = YandexSuggest.getSuggestions(
      text: query,
      boundingBox: BoundingBox(
        northEast: region.topLeft,
        southWest: region.bottomRight,
      ),
      suggestOptions: SuggestOptions(
        suggestType: SuggestType.geo,
        userPosition: userPoint,
      ),
    );

    final sessionRes = await res.result;
    suggestions.clear();
    suggestions.addAllIf(
      sessionRes.items != null && sessionRes.items!.isNotEmpty,
      sessionRes.items!,
    );
    isFetching.value = false;
  }

  void uodatePanelState(double val) {
    if (val > 0.5) {
      isCollapsed.value = false;
      return;
    }
    isCollapsed.value = true;
  }

  void onCollapsedFieldTap() {
    if (panelController.isPanelOpen) {
      return;
    }
    panelController.open();
  }

  void selectAddress(SuggestItem suggest) {
    debugPrint(suggest.tags.toString());
    addressController.value = TextEditingValue(
      text: suggest.displayText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: suggest.displayText.length),
      ),
    );
    addressFocusNode.unfocus();
    panelController.close();
    updateUserPositionOnMap(suggest.center!);
    UserService.to.updateUserAddressAndPosition(
      suggest.center!,
      suggest.displayText,
    );
  }

  void saveAddress() async {
    Get.back();
  }

  void updateUserPositionOnMap(Point point) async {
    if (placemarks.isEmpty) {
      addPositionPlacemark(point);
    }
    updatePositionPlacemark(point);
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: 18,
        ),
      ),
    );
  }

  void clearTextField() {
    if (panelController.isPanelClosed) {
      panelController.open();
      addressFocusNode.requestFocus();
    }
    addressController.clear();
  }

  void onMapCreated(YandexMapController c) {
    mapController = c;

    moveCameraToUserPosition();
  }

  void addPositionPlacemark(Point point) async {
    final userPin = PlacemarkMapObject(
      mapId: const MapObjectId('user_pin'),
      point: point,
      opacity: 1.0,
      // direction: 90,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          scale: 1,
          image: BitmapDescriptor.fromAssetImage('assets/icons/user_pin.png'),
          rotationType: RotationType.rotate,
        ),
      ),
    );

    placemarks.add(userPin);
  }

  void updatePositionPlacemark(Point point) async {
    if (placemarks.isEmpty) return;

    placemarks.first = (placemarks.first as PlacemarkMapObject).copyWith(
      point: point,
    );
  }

  void initialFetchAddress() async {
    if (addressController.text.isEmpty ||
        addressController.text == 'Введите Ваш адрес') {
      return;
    }
    getAddressSuggestions(addressController.text);
  }
}
