import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shujinko_app/app/routes/app_pages.dart';

import '../../../components/custom_search_textfield.dart';
import '../controllers/buku_controller.dart';

class BukuView extends GetView<BukuController> {
  const BukuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bg_buku.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 100, left: 10, right: 10, bottom: 20),
                child: kontenDataBuku(),
              ),
            ),
            Container(
              height: 120,
              color: Colors.black.withOpacity(0.90),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      child: CustomSearchTextField(
                        keyboardType: TextInputType.text,
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.getData();
                        },
                        hinText: "Search Book",
                        preficIcon: const Icon(Icons.search_rounded),
                        obsureText: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  Widget kontenDataKosong(){
    // Color
    const Color background = Color(0xFF0C1008);
    const Color borderColor = Color(0xFF424242);

    String keywordBuku = controller.searchController.text.toString();

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: borderColor,
                width: 1.3,
              )
          ),
          child: Center(
            child: Text(
              'Buku $keywordBuku tidak ditemukan',
              style: GoogleFonts.inriaSans(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget kontenDataBuku(){
    return Obx((){
      if (controller.dataBook.isEmpty) {
        return kontenDataKosong();
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 3 / 6,
          ),
          itemCount: controller.dataBook.length,
          itemBuilder: (context, index) {
            var buku = controller.dataBook[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBUKU,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: SizedBox(
                      height: 175, // Tetapkan tinggi container
                      child: Image.network(
                        buku.coverBuku.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Text(
                        buku.judul.toString(),
                        style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  Widget shimmerDataBuku(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: kontenDataBuku(),
    );
  }
}
