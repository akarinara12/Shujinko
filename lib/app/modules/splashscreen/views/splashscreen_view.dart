import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shujinko_app/app/routes/app_pages.dart';

import '../../../data/provider/storage_provider.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));

    Future.delayed(
      const Duration(milliseconds: 5000),((){
      String? status = StorageProvider.read(StorageKey.status);

      if (status == "logged") {
        Get.offAllNamed(Routes.LAYOUT);
      }else{
        Get.offAllNamed(Routes.LOGIN);
      }
    })
    );

    return Scaffold(
      body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/bg_splash.png'),
                fit: BoxFit.cover,
              )),
        child: Center(
          child: Lottie.asset(
            'lib/assets/logo/logo_shujinko.json',
            repeat: false,
          ),
        )
      ),
    );
  }
}
