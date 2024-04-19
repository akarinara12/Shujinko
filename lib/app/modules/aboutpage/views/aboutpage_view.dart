import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aboutpage_controller.dart';

class AboutpageView extends GetView<AboutpageController> {
  const AboutpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
      )
    );
  }
}
