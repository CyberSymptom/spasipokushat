import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/modules/seller/about/about_controller.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SellerLocationWidget extends GetView<AboutController> {
  const SellerLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 34.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: YandexMap(
          mapObjects: [
            PlacemarkMapObject(
              mapId: MapObjectId(controller.seller.sellerId),
              point: controller.seller.point,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  scale: 1.5,
                  image: BitmapDescriptor.fromAssetImage(
                    'assets/icons/user_pin.png',
                  ),
                ),
              ),
            ),
          ],
          onMapCreated: (c) {
            c.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: controller.seller.point,
                  zoom: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
