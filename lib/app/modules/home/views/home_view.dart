import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shujinko_app/app/modules/layout/controllers/layout_controller.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double barHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = height - barHeight;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            controller.getData();
          },
          child: Container(
            width: width,
            height: bodyHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/bg_home.png'),
                  fit: BoxFit.cover,
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    kontenProfile(),

                    Padding(
                      padding: EdgeInsets.only(top: height * 0.005),
                      child: kontenText(
                        "Selamat datang di Shujinko App mulai lah mencari buku favorit anda!!!",
                      ),
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),

                    sectionImage(),

                    Padding(
                      padding: EdgeInsets.only(top: height * 0.030),
                      child: SizedBox(
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Buku Terpopuler",
                              maxLines: 1,
                              style: GoogleFonts.inriaSans(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Obx(() =>
                              controller.popularBooks.isEmpty ?
                              shimmerBukuPopular() : kontenBukuPopular(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.035,
                    ),

                    SizedBox(
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Kategori Buku",
                            maxLines: 1,
                            style: GoogleFonts.inriaSans(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Obx(() =>
                          controller.kategoriBuku.isEmpty ?
                          shimmerKategoriBuku() : kontenKategoriBuku(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: height * 0.035,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Buku Terbaru",
                          maxLines: 1,
                          style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Obx(() =>
                        controller.newBooks.isEmpty ?
                          shimmerBukuTerbaru() : kontenBukuTerbaru(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget kontenProfile(){

    // ambil data username dari storage provider
    String usernameUser = "Hallo ${StorageProvider.read(StorageKey.username)}";

    // Ucapan selamat pagi sesuai jam
    var jam = DateTime.now().hour;
    String ucapan;

    if(jam >= 1 && jam <= 11){
      ucapan = "OHAYÔ GOZAIMASU";
    }else if(jam >= 11 && jam < 15){
      ucapan = "KONNICHIWA✨";
    }else if(jam >= 15 && jam < 18){
      ucapan = "KONNICHIWA☀️";
    }else {
      ucapan = "KONBANWA🌙";
    }


    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'lib/assets/images/fotoprofile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    usernameUser,
                    style: GoogleFonts.inriaSans(
                      fontSize: 16.0,
                      color: const Color(0xFFEA1818),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  AutoSizeText(
                    ucapan,
                    style: GoogleFonts.inriaSans(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )
            ],
          ),

          InkWell(
            onTap: (){

            },
            child: const Icon(
              Icons.notifications_rounded,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

  Widget kontenText(String ucapanUser){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFF1B1B1D)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: AutoSizeText(
          ucapanUser,
          minFontSize: 18,
          maxLines: 2,
          maxFontSize: 20,
          style: GoogleFonts.inriaSans(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  // Konten Buku Popular
  Widget kontenBukuPopular(){
    return SizedBox(
      height: 235,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.popularBooks.length > 10 ? 10 : controller.popularBooks.length,
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
                  child: SizedBox(
                    width: 145,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 145,
                                height: 185,
                                child: AspectRatio(
                                  aspectRatio: 4 / 6,
                                  child: Image.network(
                                    buku.coverBuku.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
            ),

            InkWell(
              onTap: () {
                Get.toNamed(Routes.BOOKPOPULAR);
              },
              child: Container(
                width: 145,
                height: 235,
                color: const Color(0XFF1B1B1D),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Lihat Semuanya",
                      style: GoogleFonts.inriaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerBukuPopular() {
    int itemCount = 4; // Atur jumlah item palsu

    return Shimmer.fromColors(
      baseColor: const Color(0xFF1B1B1D).withOpacity(0.20),
      highlightColor: Colors.grey.shade50,
      child: SizedBox(
        height: 205,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 135,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Placeholder untuk gambar buku
                    Container(
                      width: 135,
                      height: 175,
                      color: Colors.grey, // Warna placeholder
                    ),
                    const SizedBox(height: 10),
                    // Placeholder untuk judul buku
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.grey, // Warna placeholder
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  // End Konten Buku Popular

  // Konten Kategori Buku
  Widget kontenKategoriBuku() {
    return SizedBox(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 1.5,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.kategoriBuku.length,
        itemBuilder: (context, index) {
          var buku = controller.kategoriBuku[index];
          return SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.BOOKBYKATEGORI,
                    parameters: {
                      'idKategori': (buku.kategoriID ?? 0).toString(),
                      'namaKategori': (buku.namaKategori!).toString()
                    },
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0XFF1B1B1D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: FittedBox(
                  child: Text(
                    buku.namaKategori.toString(),
                    style: GoogleFonts.inriaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget shimmerKategoriBuku() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1B1B1D).withOpacity(0.20),
      highlightColor: Colors.grey.shade50,
      child: SizedBox(
        height: 45, // Sesuaikan dengan tinggi item
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3, // Menampilkan 3 item
          itemBuilder: (context, index) {
            return SizedBox(
              width: 150, // Sesuaikan dengan lebar item
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0XFF1B1B1D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Placeholder', // Teks placeholder
                      style: GoogleFonts.inriaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  // End Konten Kategori Buku

  // Konten Buku Terbaru
  Widget kontenBukuTerbaru() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 6,
      ),
      itemCount: controller.newBooks.length,
      itemBuilder: (context, index) {
        var buku = controller.newBooks[index];
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.DETAILBUKU,
              parameters: {
                'id': (buku.bukuID ?? 0).toString(),
                'judul': (buku.judulBuku!).toString()
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
                    buku.judulBuku.toString(),
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

  Widget shimmerBukuTerbaru(){

    int itemCount = 3;

    return Shimmer.fromColors(
      baseColor: const Color(0xFF1B1B1D).withOpacity(0.20),
      highlightColor: Colors.grey.shade50,
      child: SizedBox(
        height: 205,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 135,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Placeholder untuk gambar buku
                    Container(
                      width: 135,
                      height: 175,
                      color: Colors.grey, // Warna placeholder
                    ),
                    const SizedBox(height: 10),
                    // Placeholder untuk judul buku
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.grey, // Warna placeholder
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  // End Konten Buku Terbaru

  Widget sectionImage(){
    // Size
    double width = MediaQuery.of(Get.context!).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: (){
          LayoutController layoutController = Get.find<LayoutController>();
          layoutController.changeTabIndex(1);

          Get.put<LayoutController>(layoutController);
        },
        child: Container(
          width: width,
          height: 115,
          decoration: const BoxDecoration(
            image:  DecorationImage(
                image: AssetImage(
                  'lib/assets/images/konten_home.png',
                ),
                fit: BoxFit.cover
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Temukan Ribuan Buku',
                        style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 26.0
                        ),
                      ),
                      Text(
                        'Dengan sekali klik',
                        style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.0
                        ),
                      )
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    // Get.find<LayoutController>().changeTabIndex(1);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
