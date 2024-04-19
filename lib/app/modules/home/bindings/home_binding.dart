import 'package:get/get.dart';
import 'package:shujinko_app/app/modules/layout/controllers/layout_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LayoutController>(
          () => LayoutController(),
    );
    Get.put<LayoutController>(LayoutController());
  }
}
