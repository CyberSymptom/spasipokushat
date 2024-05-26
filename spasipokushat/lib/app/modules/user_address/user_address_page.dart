import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spasipokushat/app/core/theme/colors.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'user_address_controller.dart';

class UserAddressPage extends GetView<UserAddressController> {
  const UserAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        backdropEnabled: true,
        parallaxOffset: 0.5,
        minHeight: 221,
        maxHeight: Get.height * 0.9,
        margin: EdgeInsets.only(top: Get.height * 0.1),
        onPanelSlide: controller.uodatePanelState,
        controller: controller.panelController,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        body: GetX<UserAddressController>(
          builder: (addressC) {
            return YandexMap(
              mapObjects: addressC.placemarks.value,
              onMapCreated: controller.onMapCreated,
              onUserLocationAdded: (view) async {
                return view.copyWith(
                  accuracyCircle: view.accuracyCircle.copyWith(
                    isVisible: false,
                    fillColor: Colors.transparent,
                    strokeColor: Colors.transparent,
                  ),
                );
              },
            );
          },
        ),
        panel: _panel(),
        collapsed: _collapsed(),
      ),
    );
  }

  Widget _addressField() {
    return TextFormField(
      controller: controller.addressController,
      focusNode: controller.addressFocusNode,
      onChanged: (val) => controller.searchQuery.value = val,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.streetAddress,
      onTap: () => controller.onCollapsedFieldTap(),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: controller.clearTextField,
          icon: const Icon(
            Icons.cancel_rounded,
            color: Color(0xffC9C8C6),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: outlineColor,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: outlineColor,
          ),
        ),
        floatingLabelStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.normal,
          color: const Color(0xffA7A7A7),
        ),
        labelText: 'Улица и дом',
      ),
    );
  }

  Widget _panel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xff9C9C9C).withOpacity(0.4),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 18, width: double.infinity),
          _addressField(),
          const SizedBox(height: 16, width: double.infinity),
          GetX<UserAddressController>(
            builder: (controller) {
              final suggestions = controller.suggestions;
              if (suggestions.isEmpty) {
                return Center(
                  child: Text(
                    'Адрес не найден!',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: onSurfaceColor,
                      height: 1.3,
                    ),
                  ),
                );
              }
              if (controller.isCollapsed.value) {
                return const SizedBox.shrink();
              }
              if (controller.isFetching.isTrue) {
                return Visibility(
                  visible: controller.isCollapsed.value ? false : true,
                  child: Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemBuilder: (context, index) => Material(
                        color: Colors.transparent,
                        child: Skeletonizer(
                          enabled: true,
                          effect: const ShimmerEffect(
                            baseColor: Color(0xffD5D5D5),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'ул Новый Арбат 23, корпус 4, подъзд 3, Москва',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: onSurfaceColor,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        color: dividerColor,
                      ),
                      itemCount: 5,
                    ),
                  ),
                );
              }
              return Visibility(
                visible: controller.isCollapsed.value ? false : true,
                child: Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemBuilder: (context, index) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          controller.selectAddress(suggestions[index]);
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            suggestions[index].displayText,
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: onSurfaceColor,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      color: dividerColor,
                    ),
                    itemCount: suggestions.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _collapsed() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xff9C9C9C).withOpacity(0.4),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 18, width: double.infinity),
          _addressField(),
          const SizedBox(height: 16, width: double.infinity),
          GestureDetector(
            onTap: controller.saveAddress,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 17.5,
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                'Сохранить',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  color: onPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }
}
