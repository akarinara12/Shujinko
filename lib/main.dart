import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk SystemChrome

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // const Color colorText = Color(0xFFEA1818);
  const Color background = Color(0xFF03010E);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: background,
    statusBarIconBrightness: Brightness.light,// Change this color as needed
  ));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: background,
    statusBarIconBrightness: Brightness.dark,// Change this color as needed
  ));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
