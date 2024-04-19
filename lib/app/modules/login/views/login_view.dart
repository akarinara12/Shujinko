import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/customButton.dart';
import '../../../components/customTextField.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color colorText = Color(0xFFEA1818);
    const Color background = Color(0xFF03010E);
    const Color buttonColor = Color(0xFF1B1B1D);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/bg_login.png'),
              fit: BoxFit.cover,
            )
        ),

        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: textLogin("Login", "Please sign in to continue")
                  ),
                  Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [

                          CustomTextField(
                            controller: controller.emailController,
                            hinText: 'Email Address',
                            obsureText: false,
                            preficIcon: const Icon(Icons.email),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pleasse input email address';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Email address tidak sesuai';
                              }else if (!value.endsWith('@smk.belajar.id')){
                                return 'Email harus @smk.belajar.id';
                              }

                              return null;
                            },
                          ),

                          Obx(()=> CustomTextField(
                            controller: controller.passwordController,
                            hinText: 'Password',
                            obsureText: controller.isPasswordHidden.value,
                            surficeIcon: InkWell(
                              child: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: background,
                              ),
                              onTap: () {
                                controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                              },
                            ),
                            preficIcon: const Icon(Icons.lock),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pleasse input password';
                              }

                              // Validasi setidaknya satu huruf besar
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password harus mengandung satu huruf besar';
                              }

                              // Validasi setidaknya satu karakter khusus
                              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                return 'Password harus mengandung satu karakter khusus';
                              }

                              return null;
                            },
                          ),),

                          CustomButton(
                            buttonColor: buttonColor,
                            radius: 20.20,
                              onPressed: (){
                                controller.login();
                              },
                              child: Obx(() => controller.loadinglogin.value?
                              const CircularProgressIndicator(
                                color: colorText,
                              ): Text(
                                'Login',
                                style: GoogleFonts.inriaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                          ),
                          ),

                          textToRegister()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textLogin(String judul, String deskripsi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSizeText(
          judul,
          minFontSize: 18,
          maxFontSize: 40,
          style: GoogleFonts.inriaSans(
              fontSize: 40.0, fontWeight: FontWeight.w900, color: Colors.white),
        ),
        FittedBox(
          child: Text(
            deskripsi,
            style: GoogleFonts.inriaSans(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget textToRegister() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              'Belum punya akun?',
              style: GoogleFonts.inriaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.REGISTER);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: FittedBox(
              child: Text('Daftar disini',
                  style: GoogleFonts.inriaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFEA1818),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
