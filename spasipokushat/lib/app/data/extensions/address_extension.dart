import 'package:get/get.dart';
import 'package:spasipokushat/app/data/extensions/string_extension.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

extension AddressExtension on Address {
  String toReadableAddress() {
    List<Component> c = components!;
    String? city;
    String? street;
    String? house;
    String? houseName;

    if (c.firstWhereOrNull(
            (element) => element.kind == KindResponse.locality) !=
        null) {
      city = c
          .firstWhere((element) => element.kind == KindResponse.locality)
          .name!;
    }

    if (c.firstWhereOrNull((element) => element.kind == KindResponse.street) !=
        null) {
      street =
          c.firstWhere((element) => element.kind == KindResponse.street).name!;
    }

    if (c.firstWhereOrNull((element) => element.kind == KindResponse.house) !=
        null) {
      house =
          c.firstWhere((element) => element.kind == KindResponse.house).name!;
    }

    if (c
        .where((element) => element.kind == KindResponse.district)
        .isNotEmpty) {
      var districts =
          c.where((element) => element.kind == KindResponse.district);
      houseName = districts.last.name;
    }

    if (city == null) {
      return 'Введите Ваш адрес';
    }
    List address = [];

    if (street == null) {
      address.addNonNull(houseName?.capitalizeFirstLetter());
      address.addNonNull(city);

      return address.join(', ');
    }

    address.addNonNull(street);
    address.addNonNull(house);
    address.addNonNull(city);

    return address.join(', ');
  }
}
