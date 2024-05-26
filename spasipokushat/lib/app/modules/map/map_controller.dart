import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/data/dtos/seller_dto.dart';
import 'package:spasipokushat/app/data/enums/route_enum.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/app/modules/home/home_controller.dart';
import 'package:spasipokushat/app/routes/seller_routes.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapController extends GetxController {
  final DbRepository repository;
  MapController(this.repository);

  late YandexMapController mapController;

  var isControllerInitialized = false.obs;
  GlobalKey mapKey = GlobalKey();
  final mapObjects = <MapObject<dynamic>>[].obs;

  final selectedIndex = 0.obs;

  final List<SellerDto> sellers = [
    ...Get.find<HomeController>().state!.newPlaces,
    ...Get.find<HomeController>().state!.recomended,
  ];

  final hasError = false.obs;

  void initMapController(YandexMapController c) async {
    mapController = c;

    update();
  }

  @override
  void onInit() {
    addClusterToMap();
    once(
      isControllerInitialized,
      (callback) async {
        await moveCameraToUserPosition();
      },
      condition: () => isControllerInitialized.isTrue,
      onDone: () => debugPrint('user point added to map'),
    );
    super.onInit();
  }

  Future<void> moveCameraToUserPosition() async {
    Point location = const Point(latitude: 55.755820, longitude: 37.617633);

    final userLocation = UserService.to.userPosition.value;

    if (userLocation != null) {
      location = userLocation;
    }

    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 9),
      ),
      animation: const MapAnimation(duration: 0),
    );
  }

  void addClusterToMap() async {
    final res = await repository.fetchAllSellersPoint();

    if (res == null) {
      hasError.value = true;
      return;
    }

    var mapObject = ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized_placemark_collection'),
      placemarks: res
          .map(
            (e) => PlacemarkMapObject(
              mapId: MapObjectId(e.id),
              consumeTapEvents: true,
              onTap: (mapObject, point) {
                openSellerPage(mapObject: mapObject);
              },
              point: Point(latitude: e.latitude, longitude: e.longitude),
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                    'assets/icons/user_pin.png',
                  ),
                  scale: 1.5,
                ),
              ),
            ),
          )
          .toList(),
      radius: 30,
      minZoom: 16,
      onClusterAdded:
          (ClusterizedPlacemarkCollection self, Cluster cluster) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 0.75,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await buildClusterAppearance(cluster),
                ),
                scale: 1,
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        final info = await mapController.getCameraPosition();

        await mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: cluster.appearance.point,
              zoom: info.zoom + 2,
            ),
          ),
        );
      },
    );

    mapObjects.add(mapObject);
  }

  void openSellerPage({PlacemarkMapObject? mapObject, SellerDto? seller}) {
    String sellerId = '';
    RouteEnum route = RouteEnum.app;

    if (mapObject != null) {
      sellerId = mapObject.mapId.value;
      route = RouteEnum.map;
    }

    if (seller != null) {
      sellerId = seller.sellerId;
    }
    Get.toNamed(
      SellerRoutes.seller,
      arguments: seller,
      parameters: {
        'id': sellerId,
        'route': route.name,
      },
    );
  }

  Future<Uint8List> buildClusterAppearance(Cluster cluster) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 200);
    final fillPaint = Paint()
      ..color = const Color(0xffFF7700)
      ..style = PaintingStyle.fill;

    const radius = 60.0;

    final textPainter = TextPainter(
      text: TextSpan(
        text: cluster.size.toString(),
        style: GoogleFonts.ubuntu(
          fontSize: 50,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset((size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    // canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }
}
