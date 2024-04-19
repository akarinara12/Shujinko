import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/customButton.dart';
import '../../../components/customTextFieldProfile.dart';
import '../controllers/updateprofile_controller.dart';

class UpdateprofileView extends GetView<UpdateprofileController> {
  const UpdateprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double barHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = height - barHeight;

    const Color colorText = Color(0xFFEA1818);
    const Color background = Color(0xFF03010E);
    const Color buttonColor = Color(0xFF1B1B1D);


    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          toolbarHeight: 55,
          titleSpacing: -5,
          title: Text(
            'Perbarui Informasi Akun Anda',
            style: GoogleFonts.inriaSans(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      body: Container(
        width: width,
        height: bodyHeight,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'lib/assets/images/bg_history.png',
                )
            )
        ),
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(
                    height: 25,
                  ),

                  Text(
                    'Update Profile',
                    style: GoogleFonts.inriaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  CustomTextFieldProfile(
                    controller: controller.namalengkapController,
                    hinText: 'Nama lengkap',
                    obsureText: false,
                    preficIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input nama lengkap';
                      }

                      return null;
                    },
                  ),

                  CustomTextFieldProfile(
                    controller: controller.usernameController,
                    hinText: 'Username',
                    obsureText: false,
                    preficIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input username';
                      }

                      return null;
                    },
                  ),

                  CustomTextFieldProfile(
                    controller: controller.emailController,
                    hinText: 'Email',
                    obsureText: false,
                    preficIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input email';
                      }

                      return null;
                    },
                  ),

                  CustomTextFieldProfile(
                    controller: controller.bioController,
                    hinText: 'Bio',
                    obsureText: false,
                    preficIcon: const Icon(Icons.info),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input bio';
                      }

                      return null;
                    },
                  ),

                  CustomTextFieldProfile(
                    controller: controller.teleponController,
                    hinText: 'No Telepon',
                    obsureText: false,
                    preficIcon: const Icon(Icons.call),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input telepon';
                      }

                      return null;
                    },
                  ),

                  CustomButton(
                    buttonColor:buttonColor,
                    radius: 20.20,
                    onPressed: (){
                      controller.updateProfilePost();
                    },
                    child: Obx(() => controller.loading.value?
                    const CircularProgressIndicator(
                      color: colorText,
                    ): Text(
                      'Update Profile',
                      style: GoogleFonts.inriaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
