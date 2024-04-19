import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shujinko_app/app/routes/app_pages.dart';

import '../controllers/buktipeminjaman_controller.dart';

class BuktipeminjamanView extends GetView<BuktipeminjamanController> {
  const BuktipeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'lib/assets/images/bg_history.png',
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: kontenData(width, height),
          ),
        ),
      )
    );
  }

  Widget kontenData(double width, double height){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Obx((){
        String asalHalaman = Get.parameters['asalHalaman'].toString();

        if (controller.detailPeminjaman.value == null){
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
              ),
            ),
          );
        }else{
          var dataPeminjaman = controller.detailPeminjaman.value;

          return Column(
            children: [
              FittedBox(
                child: Text(
                  'Peminjaman Buku Berhasil',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 26.0
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.010,
              ),

              Divider(
                color: Colors.black.withOpacity(0.10),
                thickness: 1,
              ),

              SizedBox(
                height: height * 0.015,
              ),

              FittedBox(
                child: Text(
                  dataPeminjaman!.kodePeminjaman.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFEA1818),
                      fontSize: 36.0
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.030,
              ),

              kontenBuktiPeminjaman(
                  'Tanggal Peminjaman', dataPeminjaman.tanggalPinjam.toString()
              ),

              SizedBox(
                height: height * 0.015,
              ),

              kontenBuktiPeminjaman(
                  'Deadline Peminjaman', dataPeminjaman.deadline.toString()
              ),

              SizedBox(
                height: height * 0.040,
              ),

              Divider(
                color: Colors.black.withOpacity(0.10),
                thickness: 1,
              ),

              SizedBox(
                height: height * 0.030,
              ),

              kontenBuktiPeminjaman(
                  'Nama Peminjam', dataPeminjaman.username.toString()
              ),

              SizedBox(
                height: height * 0.015,
              ),

              kontenBuktiPeminjaman(
                  'Nama Buku', dataPeminjaman.judulBuku.toString()
              ),

              SizedBox(
                height: height * 0.015,
              ),

              kontenBuktiPeminjaman(
                  'Penulis Buku', dataPeminjaman.penulisBuku.toString()
              ),

              SizedBox(
                height: height * 0.015,
              ),

              kontenBuktiPeminjaman(
                  'Tahun Terbit', dataPeminjaman.tahunBuku.toString()
              ),

              SizedBox(
                height: height * 0.040,
              ),

              FittedBox(
                child: Text(
                  'Note:',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFEA1818),
                      fontSize: 24.0
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.010,
              ),

              FittedBox(
                child: Text(
                  'Harap kembalikan buku tepat waktu. Terima kasih.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFEA1818),
                      fontSize: 14.0
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.050,
              ),

              kontenButton(
                  (){

                  },
                  Text(
                      'Screenshot Bukti Peminjaman',
                      style: GoogleFonts.inriaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  100.0,
                  const Color(0xFF1B1B1D)
              ),

              SizedBox(
                height: height * 0.015,
              ),

              kontenButton(
                      (){
                        String asalHalaman = Get.parameters['asalHalaman'].toString();
                        if (asalHalaman == 'detailBuku') {
                          Get.offAllNamed(Routes.LAYOUT); // Navigasi ke halaman detail buku
                        } else if (asalHalaman == 'historyPeminjaman') {
                          Get.back();
                        }
                  },
                  Text(
                    asalHalaman == 'detailBuku' ? 'Kembali ke Beranda' : 'Kembali',
                    style: GoogleFonts.inriaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  100.0,
                  const Color(0xFFEA1818)
              ),
            ],
          );
        }
      })
    );
  }

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inriaSans(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          ),

          Flexible(
            flex: 3,
            child: Text(
              isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inriaSans(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kontenButton(final onPressed,final Widget child,
  final double radius,
  final Color buttonColor,){
    const Color borderColor = Color(0xFF424242);
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
            side: const BorderSide(
              color: borderColor, // Warna border (stroke)
              width: 1.3, // Lebar border (stroke)
            ),
          ),
          onPressed: onPressed,
          child: child,
        )
    );
  }
}
