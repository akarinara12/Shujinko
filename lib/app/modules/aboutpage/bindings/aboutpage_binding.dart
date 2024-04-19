import 'package:get/get.dart';

import '../controllers/aboutpage_controller.dart';

class AboutpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutpageController>(
      () => AboutpageController(),
    );
  }
}
