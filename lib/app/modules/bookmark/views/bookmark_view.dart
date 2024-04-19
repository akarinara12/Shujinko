
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shujinko_app/app/components/customTabBar.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    const Color background = Color(0xFF03010E);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: background,
            title: Text(
              'Activitas Pengguna',
              style: GoogleFonts.inriaSans(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: background,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: Color(0xFFEA1818),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    CustomTabBar(
                        tittle: 'History Peminjaman',
                        onTap: () async{
                          await controller.getDataPeminjaman();
                        },
                        widgetText: Obx(() =>
                            Text(
                              controller.historyPeminjaman.length > 20 ? "20++" : controller.historyPeminjaman.length.toString(),
                              style: GoogleFonts.inriaSans(
                                color: const Color(0xFFEA1818),
                              ),
                            )),
                        count: controller.historyPeminjaman.length
                    ),
                    CustomTabBar(
                        tittle: 'Koleksi Buku',
                        onTap: () async{
                          await controller.getDataKoleksi();
                        },
                        widgetText: Obx(() =>
                            Text(
                              controller.koleksiBook.length > 20 ? "20++" : controller.koleksiBook.length.toString(),
                              style: GoogleFonts.inriaSans(
                                color: const Color(0xFFEA1818),
                              ),
                        )),
                        count: controller.koleksiBook.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/bg_history.png',
                          ),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.025,
                          ),

                          Obx(() => controller.historyPeminjaman.isEmpty ?
                              kontenDataKosong('History Peminjaman') :
                              kontenHistoryPeminjaman(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/bg_bookmark.png',
                          ),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.025,
                          ),

                          Obx(() => controller.koleksiBook.isEmpty ?
                          kontenDataKosong('Koleksi Buku') :
                          kontenKoleksiBuku(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget kontenHistoryPeminjaman() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          controller.historyPeminjaman.length,
              (index) {
            var dataHistory = controller.historyPeminjaman[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: (){
                  dataHistory.status == 'Selesai' ? controller.kontenBeriUlasan(dataHistory.bukuId.toString(), dataHistory.judulBuku.toString()) :
                  Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
                    'idPeminjaman': dataHistory.peminjamanID.toString(),
                    'asalHalaman' : 'historyPeminjaman',
                  });
                },
                child: Container(
                  width: MediaQuery.of(Get.context!).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFF424242).withOpacity(0.70),
                      borderRadius: BorderRadius.circular(10)),
                  height: 190,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Gambar di sebelah kiri
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          height: 190,
                          // Lebar gambar 40% dari layar
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 5 / 7,
                                  child: Image.network(
                                    dataHistory.coverBuku.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: dataHistory.status == 'Ditolak'
                                          ? const Color(0xFFEA1818)
                                          : dataHistory.status == 'Dipinjam'
                                          ? const Color(0xFFFBC446)
                                          : dataHistory.status ==
                                          'Selesai'
                                          ? const Color(0xFF005D14)
                                          : const Color(0xFF1B1B1D),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          dataHistory.status == 'Selesai' ? const SizedBox() : const FaIcon(
                                            FontAwesomeIcons.circleInfo,
                                            color: Colors.white,
                                            size: 20,
                                          ),


                                          dataHistory.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                            width: 10,
                                          ),

                                          Text(
                                            dataHistory.status == 'Selesai' ? 'Beri Ulasan' : dataHistory.status.toString(),
                                            style: GoogleFonts.inriaSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No: ${dataHistory.kodePeminjaman}',
                                style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                dataHistory.judulBuku!,
                                style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              FittedBox(
                                child: Text(
                                  'Tanggal pinjam: ${dataHistory.tanggalPinjam}',
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  'Deadline: ${dataHistory.deadline}',
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  'Tanggal kembali: ${dataHistory.tanggalKembali}',
                                  style: GoogleFonts.inriaSans(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget kontenKoleksiBuku() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 3 / 6,
      ),
      itemCount: controller.koleksiBook.length,
      itemBuilder: (context, index) {
        var dataKoleksi = controller.koleksiBook[index];
        return InkWell(
          onTap: () {
            Get.toNamed(
              Routes.DETAILBUKU,
              parameters: {
                'id': (dataKoleksi.bukuID ?? 0).toString(),
                'judul': (dataKoleksi.judul!).toString(),
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 175, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
                      child: AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Image.network(
                          dataKoleksi.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.80),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Color(0xFFEA1818),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Disimpan",
                                    style: GoogleFonts.inriaSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 3.0),
                  child: Text(
                    dataKoleksi.judul!,
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

  Widget kontenDataKosong(String string){
    // Color
    const Color background = Color(0xFF0C1008);
    const Color borderColor = Color(0xFF424242);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
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
              'Data $string kosong',
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
}
