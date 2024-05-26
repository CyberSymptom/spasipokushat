import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:spasipokushat/app/data/enums/route_enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:math' as math;

class UtilsHelper {
  static Future<bool> get hasGeoLocationPermissionGranted async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Position?> requestGeolocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return null;
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    try {
      final res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return res;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static RouteEnum definePreviousRoute(Map<String, String?> params) {
    if (!params.containsKey('route')) {
      return RouteEnum.undefined;
    } else if (params['route'] == RouteEnum.app.name) {
      return RouteEnum.app;
    } else if (params['route'] == RouteEnum.push.name) {
      return RouteEnum.push;
    } else {
      return RouteEnum.undefined;
    }
  }

  static void openUrl(String url) async {
    Uri uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Произошла ошибка, попробуйте еще раз.',
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    await launchUrl(uri);
  }

  static void openYandexMap(
    double distLat,
    double distLong,
  ) async {
    Uri uri = Uri.parse(
        'yandexnavi://build_route_on_map?lat_to=$distLat&lon_to=$distLong');
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Uri mapUrl = Uri.https(
        'yandex.ru',
        '/maps/',
        {
          'pt': '$distLat,$distLong',
          'z': '12',
          'l': 'map',
        },
      );

      await launchUrl(mapUrl);
    }
  }

  static double? toDoubleIfInt(dynamic val) {
    if (val.runtimeType == int) {
      return double.parse(val);
    }
    return val;
  }

  static List<Point> calculateMaxMinGeo({
    required int radius,
    required Point point,
  }) {
    const double oneDegreeInKm =
        111.134861111; // Расстояние в километрах на один градус

    double maxLat = point.latitude + (radius / oneDegreeInKm);
    double minLat = point.latitude - (radius / oneDegreeInKm);

    double maxLon =
        point.longitude + (radius / (oneDegreeInKm * math.cos(point.latitude)));
    double minLon =
        point.longitude - (radius / (oneDegreeInKm * math.cos(point.latitude)));

    final res = [
      Point(latitude: minLat, longitude: minLon),
      Point(latitude: maxLat, longitude: maxLon),
    ];
    debugPrint(res[0].toString());
    debugPrint(res[1].toString());

    return res;
  }

  // Функция для расчета координат для прямоугольной области
  static List<Point> calculateBoundingBox(
      double lat, double lon, double radiusInKm) {
    // Радиус Земли в километрах
    const double earthRadius = 6371.0;

    // Преобразование радиуса из километров в радианы
    double radiusInRadians = radiusInKm / earthRadius;

    // Преобразование градусов широты и долготы в радианы
    double latRad = radians(lat);
    double lonRad = radians(lon);

    // Рассчет новых координат для западной (левой) границы
    double newLonWest = degrees(lonRad - radiusInRadians / math.cos(latRad));

    // Рассчет новых координат для восточной (правой) границы
    double newLonEast = degrees(lonRad + radiusInRadians / math.cos(latRad));

    // Рассчет новых координат для южной (нижней) границы
    double newLatSouth = degrees(latRad - radiusInRadians);

    // Рассчет новых координат для северной (верхней) границы
    double newLatNorth = degrees(latRad + radiusInRadians);

    return [
      Point(
        latitude: newLatSouth,
        longitude: newLonWest,
      ), // Нижняя левая точка

      Point(
        latitude: newLatNorth,
        longitude: newLonEast,
      ), // Верхняя правая точка
    ];
  }

// Функция для преобразования градусов в радианы
  static double radians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

// Функция для преобразования радиан в градусы
  static double degrees(double radians) {
    return radians * (180.0 / math.pi);
  }
}
