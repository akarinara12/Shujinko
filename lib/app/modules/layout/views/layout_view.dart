import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shujinko_app/app/modules/aboutpage/views/aboutpage_view.dart';
import '../../bookmark/views/bookmark_view.dart';
import '../../buku/views/buku_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color background = Color(0xFF03010E);
    const Color colorSelect =  Color(0xFFEA1818);
    const Color colorBlack =  Color(0xFF1B1B1D);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));

    List<Icon> iconList = const [
      Icon(Icons.house_rounded, size: 30, color: Colors.white),
      Icon(Icons.explore, size: 30, color: Colors.white),
      Icon(Icons.history, size: 30, color: Colors.white),
      Icon(Icons.person_rounded, size: 30, color: Colors.white),
    ];

    return GetBuilder<LayoutController>(
        builder: (controller) {
          return Scaffold(
            body: Center(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: const [
                     HomeView(),
                     BukuView(),
                     BookmarkView(),
                     ProfileView(),
                  ],
                )
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: controller.bottomKey,
              index: 0,
              height: 68.0,
              items: [
                iconList[0], // Icon 1
                iconList[1], // Icon 2
                iconList[2], // Icon 3
                iconList[3], // IconIcon 5
              ],
              color: background,
              buttonBackgroundColor: colorSelect,
              backgroundColor: colorBlack,
              animationCurve: Curves.decelerate,
              animationDuration: const Duration(milliseconds: 600),
              onTap:  (index) => controller.changeTabIndex(index),
              letIndexChange: (index) => true,
            ),
          );
        });
  }

}