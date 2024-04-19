import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {

  GlobalKey<CurvedNavigationBarState> bottomKey = GlobalKey();

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
