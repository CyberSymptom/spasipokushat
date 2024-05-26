import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/data/providers/db_provider.dart';
import 'package:spasipokushat/app/data/repositories/db_repository.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../home/widgets/widgets.dart';
import 'map_controller.dart';
import 'widgets/widgets.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MapController>(
      init: MapController(DbRepository(DbProvider())),
      builder: (controller) {
        return Stack(
          children: [
            Obx(
              () {
                if (controller.selectedIndex.value == 0) {
                  return YandexMap(
                    mapObjects: controller.mapObjects.value,
                    key: controller.mapKey,
                    onMapCreated: (c) async {
                      controller.initMapController(c);
                      controller.moveCameraToUserPosition();
                    },
                    onCameraPositionChanged:
                        (cameraPosition, reason, finished) {},
                  );
                } else {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        top: Get.mediaQuery.viewPadding.top + 136),
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(22, 14, 22, 34),
                      itemBuilder: (context, int index) {
                        return AspectRatio(
                          aspectRatio: 16 / 9.5,
                          child: CarouselCard(
                            seller: controller.sellers[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: controller.sellers.length,
                    ),
                  );
                }
              },
            ),
            Visibility(
              visible: controller.selectedIndex.value == 0 ? true : false,
              child: const Positioned(
                bottom: 27,
                child: RestaurantList(),
              ),
            ),
            Positioned(
              top: Get.mediaQuery.viewPadding.top + 20,
              left: 24,
              right: 24,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchBarWidget(),
                  SizedBox(height: 12),
                  SegmentedButtonWidget(),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
