import 'package:get/get.dart';
import 'package:shujinko_app/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:shujinko_app/app/modules/buku/controllers/buku_controller.dart';
import 'package:shujinko_app/app/modules/home/controllers/home_controller.dart';
import 'package:shujinko_app/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<BukuController>(
          () => BukuController(),
    );
    Get.lazyPut<BookmarkController>(
          () => BookmarkController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
