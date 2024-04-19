import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../components/customTextFieldPeminjaman.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/bookmarknhistory/response_peminjaman.dart';
import '../../../data/model/buku/response_detail_buku.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class DetailbukuController extends GetxController with StateMixin{

  // Post Data
  final loading = false.obs;

  // Get Data
  var detailBuku = Rxn<DataDetailBuku>();
  final id = Get.parameters['id'];

  late String formattedToday;
  late String formattedTwoWeeksLater;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }

  // Data Peminjaman
  late String statusDataPeminjaman;

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku(id);

    // Get Tanggal hari ini
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 14));

    // Format tanggal menjadi string menggunakan intl package
    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> getDataDetailBuku(String? idBuku) async {
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailBuku}/$idBuku');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailBuku responseBuku = ResponseDetailBuku.fromJson(responseDetailBuku.data);
        statusDataPeminjaman = responseBuku.data!.buku!.statusPeminjaman.toString();

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          detailBuku(responseBuku.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  addKoleksiBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().post(
        Endpoint.koleksiBuku,
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBuku = Get.parameters['judul'].toString();
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Berhasil",
          "Buku $judulBuku berhasil disimpan di koleksi buku",
          "Oke",
        );
        getDataDetailBuku(bukuID);
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal disimpan, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  deleteKoleksiBook() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().delete(
          '${Endpoint.deleteKoleksi}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        String judulBuku = Get.parameters['judul'].toString();
        _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Berhasil",
            "Buku $judulBuku berhasil dihapus di koleksi buku",
            "Oke",
        );
        getDataDetailBuku(bukuID);
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal dihapus, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['Message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF03010E),
          title: Text(
            'Shujinko App',
            style: GoogleFonts.inriaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: const Color(0xFFEA1818),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  judul,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 20.0
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              autofocus: true,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFEA1818),
                animationDuration: const Duration(milliseconds: 300),
              ),
              onPressed: onPressed,
              child: Text(
                nameButton,
                style: GoogleFonts.inriaSans(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        ResponsePeminjaman responsePeminjaman = ResponsePeminjaman.fromJson(responsePostPeminjaman.data!);
        String judulBuku = Get.parameters['judul'].toString();
        String peminjamanID = responsePeminjaman.data!.peminjamanID.toString();

        _showMyDialog(
              () {
            Get.offAllNamed(Routes.BUKTIPEMINJAMAN, parameters: {
              'idPeminjaman': peminjamanID,
              'asalHalaman' : 'detailBuku',
            });
            getDataDetailBuku(bukuID);
          },
          "Peminjaman Berhasil",
          "Buku $judulBuku berhasil dipinjam",
          "Oke",
        );
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal disimpan, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> showConfirmPeminjaman(final onPressed, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: GoogleFonts.inriaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: const Color(0xFFEA1818),
          ),
          backgroundColor: const Color(0xFF03010E),
          title: Text(
            'Konfirmasi Peminjaman',
            style: GoogleFonts.inriaSans(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: const Color(0xFFEA1818),
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: ListBody(
                children: <Widget>[

                  CustomTextFieldPeminjaman(
                    InitialValue: Get.parameters['judul'].toString(),
                    labelText: 'Judul Buku',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    InitialValue: formattedToday.toString(),
                    labelText: 'Tanggal Peminjaman',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    InitialValue: formattedTwoWeeksLater.toString(),
                    labelText: 'Deadline Pengembalian',
                    obsureText: false,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        value: isChecked.value,
                        onChanged: (value) {
                          toggleCheckBox();
                        },
                        activeColor: const Color(0xFFEA1818),
                      )
                      ),
                      Expanded(
                        child: Text(
                          "Setuju dengan jadwal peminjaman waktu",
                          maxLines: 1,
                          style: GoogleFonts.inriaSans(
                            fontSize: 10.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF1B1B1D),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            Navigator.pop(Get.context!, 'OK');
                          },
                          child: Text(
                            'Batal',
                            style: GoogleFonts.inriaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFEA1818),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            if (!isChecked.value) {
                              return;
                            }
                            Navigator.pop(Get.context!, 'OK');
                            addPeminjamanBuku();
                          },
                          child: Text(
                            nameButton,
                            style: GoogleFonts.inriaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
