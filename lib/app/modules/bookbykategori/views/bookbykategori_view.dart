import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookbykategori_controller.dart';

class BookbykategoriView extends GetView<BookbykategoriController> {
  const BookbykategoriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    const Color background = Color(0xFF070707);
    
    String namaKategori = Get.parameters['namaKategori'].toString();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 55,
        titleSpacing: -5,
        title: Text(
          'Buku Berdasarkan $namaKategori',
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
        child: RefreshIndicator(
          onRefresh: () async{
            await controller.getDataBookKategori();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: kontenDataBook(),
            ),
          ),
        ),
      )
    );
  }

  Widget kontenDataBook() {
    return Obx((){
      if (controller.dataBookByKategori.isEmpty) {
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
          itemCount: controller.dataBookByKategori.length,
          itemBuilder: (context, index) {
            var buku = controller.dataBookByKategori[index];
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

  Widget kontenDataKosong(){
    // Color
    const Color background = Color(0xFF0C1008);
    const Color borderColor = Color(0xFF424242);

    String namaBuku = Get.parameters['namaKategori'].toString();

    return Center(
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
            'Buku $namaBuku tidak ditemukan',
            style: GoogleFonts.inriaSans(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
