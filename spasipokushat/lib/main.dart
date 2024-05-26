import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spasipokushat/app/core/theme/fonts.dart';
import 'package:spasipokushat/app/core/theme/light_theme.dart';
import 'package:spasipokushat/app/data/services/appwrite_service.dart';
import 'package:spasipokushat/app/data/services/user_service.dart';
import 'package:spasipokushat/firebase_options.dart';

import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await initGoogleFonts();
  await initServices();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'СпасиПокушать',
      initialBinding: ApplicationBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      locale: const Locale('ru', 'RU'),
      supportedLocales: const [Locale('ru', 'RU')],
      fallbackLocale: const Locale('ru', 'RU'),
      themeMode: ThemeMode.system,
      theme: lightTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ),
  );
}

Future<void> initServices() async {
  await Get.putAsync(() => AppwriteService().init());
  await Get.putAsync(() => UserService().init());
}

Future<void> initGoogleFonts() async {
  await GoogleFonts.pendingFonts([
    primaryFont,
    secondaryFont,
  ]);
}
