import 'package:get/get.dart';

import '../controllers/bookpopular_controller.dart';

class BookpopularBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookpopularController>(
      () => BookpopularController(),
    );
  }
}
