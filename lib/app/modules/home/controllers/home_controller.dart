import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shujinko_app/app/data/model/buku/response_book_new.dart';
import 'package:shujinko_app/app/data/model/buku/response_popular_book.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/kategori/response_kategori.dart';
import '../../../data/provider/api_provider.dart';

class HomeController extends GetxController with StateMixin {
  var newBooks = RxList<DataBookNew>();
  var popularBooks = RxList<DataPopularBook>();
  var kategoriBuku = RxList<DataKategori>();

  @override
  void onInit() {
    super.onInit();
    getDataNewBook();
    getDataPopularBook();
    getDataKategoriBook();
  }

  void getData(){
     getDataNewBook();
     getDataPopularBook();
     getDataKategoriBook();
  }

  Future<void> getDataNewBook() async {
    newBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseNew = await ApiProvider.instance().get(Endpoint.bukuNew);

      if (responseNew.statusCode == 200) {
        final ResponseBookNew responseBukuNew = ResponseBookNew.fromJson(responseNew.data);

        if (responseBukuNew.data!.isEmpty) {
          newBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          newBooks.assignAll(responseBukuNew.data!);

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

  Future<void> getDataPopularBook() async {
    popularBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responsePopular = await ApiProvider.instance().get(Endpoint.bukuPopular);

      if (responsePopular.statusCode == 200) {
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBukuPopular.data!.isEmpty) {
          popularBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          popularBooks.assignAll(responseBukuPopular.data!);

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

  Future<void> getDataKategoriBook() async {
    kategoriBuku.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseKategori = await ApiProvider.instance().get(Endpoint.kategoriBuku);

      if (responseKategori.statusCode == 200) {
        final ResponseKategori responseKategoriBuku = ResponseKategori.fromJson(responseKategori.data);

        if (responseKategoriBuku.data!.isEmpty) {
          kategoriBuku.clear();
          change(null, status: RxStatus.empty());
        } else {
          kategoriBuku.assignAll(responseKategoriBuku.data!);

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
}
