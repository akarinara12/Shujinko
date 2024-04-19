import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbuku_controller.dart';

class DetailbukuView extends GetView<DetailbukuController> {
  const DetailbukuView({Key? key}) : super(key: key);
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
            'Detail Buku',
            style: GoogleFonts.inriaSans(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            Obx(() {
              var dataBuku = controller.detailBuku.value?.buku;
              return SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Icon(
                    dataBuku?.status == 'Tersimpan'
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.suit_heart,
                    color: dataBuku?.status == 'Tersimpan'
                        ? const Color(0xFFEA1818)
                        : Colors.white,
                    size: 24,
                  ),
                  onPressed: () {
                    if (dataBuku?.status == 'Tersimpan') {
                      controller.deleteKoleksiBook();
                    } else {
                      controller.addKoleksiBuku();
                    }
                  },
                ),
              );
            })
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          width: width,
          height: bodyHeight,
          color: background,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 95), // Sesuaikan dengan tinggi tombol
                  child: kontenDataDetailBuku(),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: width,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF070707),
                      border: Border(
                        top: BorderSide(
                          color: const Color(0xFF424242).withOpacity(0.50),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: buttonDetailBuku(),
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget kontenDataDetailBuku() {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    return Obx(() {
      if(controller.detailBuku.value == null){
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
            ),
          ),
        );
      }
        var dataBuku = controller.detailBuku.value?.buku;
        var dataKategori = controller.detailBuku.value?.kategori;
        var dataUlasan = controller.detailBuku.value?.ulasan;
        return Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                width: width,
                height: height * 0.40,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF070707).withOpacity(0.40),
                        const Color(0xFF070707)
                      ],
                      stops: const [0, 0.8681],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.network(
                    dataBuku!.coverBuku.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.050,
                  ),

                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 180,
                      child: Image.network(
                        dataBuku.coverBuku.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  FittedBox(
                    child: Text(
                      dataBuku.judul!,
                      style: GoogleFonts.inriaSans(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 26.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  FittedBox(
                    child: Text(
                      "Penulis: ${dataBuku.penulis!}",
                      style: GoogleFonts.inriaSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  // Menampilkan rating di bawah teks penulis
                  RatingBarIndicator(
                    rating: dataBuku.rating!,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: const Color(0xFF070707),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF424242),
                          width: 0.5,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  dataBuku.jumlahHalaman!,
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  'Halaman',
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 1,
                            color: Colors.white,
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  dataBuku.jumlahRating!.toString(),
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  'Rating',
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 1,
                            color: Colors.white,
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  dataBuku.jumlahPeminjam!.toString(),
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  'Peminjam',
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Text(
                        "Deskripsi Buku:",
                        style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Text(
                        dataBuku.deskripsi!,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.80),
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      Wrap(
                        children: dataKategori!.map((kategori) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: () {
                                // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF5F5F5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Text(
                                kategori,
                                style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.w700,
                                  color: Colors
                                      .black, // Sesuaikan dengan warna yang diinginkan
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: height * 0.020,
                      ),
                      FittedBox(
                        child: Text(
                          "Penerbit: ${dataBuku.penerbit!}",
                          style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      Text(
                        "Ulasan Buku",
                        style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      buildUlasanList(dataUlasan),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
            },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ulasanList.length,
            itemBuilder: (context, index) {
              Ulasan ulasan = ulasanList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF070707),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF424242),
                        width: 0.5,
                      )),
                  width: width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'lib/assets/images/fotoprofile.png',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.035,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ulasan.users?.username ?? '',
                                style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 10),
                              ),

                              AutoSizeText(
                                ulasan.ulasan ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 14.0),
                              ),

                              // Menampilkan rating di bawah teks penulis
                              RatingBarIndicator(
                                direction: Axis.horizontal,
                                rating: ulasan.rating!.toDouble(),
                                itemCount: 5,
                                itemSize: 10,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            width: width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1D),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF424242),
                width: 0.5,
              ),
            ),
            child: Text(
              'Belum ada ulasan buku',
              style: GoogleFonts.inriaSans(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFFEA1818);
    const Color borderColor = Color(0xFF424242);

    return Obx(() {
      var detailBuku = controller.detailBuku.value;

      var dataBuku = detailBuku?.buku;

      return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: dataBuku?.statusPeminjaman == 'Belum dipinjam' ? buttonColor : const Color(0xFFFBC446),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: borderColor.withOpacity(0.30),
              width: 1.3,
            ),
          ),
          onPressed: () {
            if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
              controller.showConfirmPeminjaman(() => Navigator.pop(Get.context!, 'OK'), 'Lanjutkan');
            }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
              return;
            }
          },
          child: Text(
            dataBuku?.statusPeminjaman == 'Belum dipinjam'
                ? 'Pinjam Buku' : 'Dipinjam',
            style: GoogleFonts.inriaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

}
