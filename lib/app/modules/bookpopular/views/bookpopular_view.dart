import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookpopular_controller.dart';

class BookpopularView extends GetView<BookpopularController> {
  const BookpopularView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    const Color background = Color(0xFF070707);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 55,
        titleSpacing: -5,
        title: Text(
          'Buku Popular',
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
              await controller.getDataPopularBook();
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
      if (controller.popularBooks.isEmpty) {
        return kontenDataKosong();
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 7,
          ),
          itemCount: controller.popularBooks.length,
          itemBuilder: (context, index) {
            var buku = controller.popularBooks[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBUKU,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: AspectRatio(
                aspectRatio: 4 / 7,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            buku.coverBuku.toString(),
                            fit: BoxFit.cover,
                          ),

                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEA1818).withOpacity(0.9),
                              ),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(), // Nomor urut buku
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            left: 0,
                            bottom: -0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.80)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: RatingBarIndicator(
                                    rating: buku.rating ?? 0,
                                    itemCount: 5,
                                    direction: Axis.horizontal,
                                    itemSize: 15,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          buku.judul.toString(),
                          style: GoogleFonts.inriaSans(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 14.0
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
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
