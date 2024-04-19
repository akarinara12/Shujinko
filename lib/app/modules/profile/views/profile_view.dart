import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shujinko_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double barHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = height - barHeight;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: bodyHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'lib/assets/images/bg_history.png',
                  ))),
          child: SingleChildScrollView(child: kontenDataProfile(width, height)),
        ),
      ),
    );
  }

  Widget kontenProfileUser(String dataUser) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataUser,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inriaSans(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget kontenDataProfile(double width, double height) {
    return Obx(() {
      if (controller.detailProfile.value == null) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
            ),
          ),
        );
      } else {
        var dataUser = controller.detailProfile.value;
        return SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.080,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'lib/assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      bottom: 3,
                      child: InkWell(
                        onTap: () async {
                          await controller.getDataUser();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.010,
                ),
                Text(
                  'Bio : ${dataUser?.bio.toString()}',
                  style: GoogleFonts.inriaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                SizedBox(
                  width: 120,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        Routes.UPDATEPROFILE,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD9D9D9).withOpacity(0.20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.inriaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                kontenProfileUser(
                    'Nama Lengkap : ${dataUser?.namaLengkap.toString()}'),
                kontenProfileUser(
                    'Username : ${dataUser?.username.toString()}'),
                kontenProfileUser('Email : ${dataUser?.email.toString()}'),
                kontenProfileUser('Bio : ${dataUser?.bio.toString()}'),
                kontenProfileUser(
                    'No Telepon : ${dataUser?.telepon.toString()}'),

                SizedBox(
                  height: height * 0.050,
                ),

                SizedBox(
                  width: width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
