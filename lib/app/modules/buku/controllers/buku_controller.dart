import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shujinko_app/app/data/model/buku/response_all_book.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class BukuController extends GetxController with StateMixin{

  var dataBook = RxList<DataBook>();


  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    dataBook.clear();
    change(null, status: RxStatus.loading());

    try {

      final keyword = searchController.text.toString();
      final responseSemuaBook;

      if(keyword == ''){
        responseSemuaBook = await ApiProvider.instance().get('${Endpoint.buku}all/buku/null');
      }else{
        responseSemuaBook = await ApiProvider.instance().get('${Endpoint.buku}all/buku/$keyword');
      }

      if (responseSemuaBook.statusCode == 200) {
        final ResponseAllBook responseDataBook = ResponseAllBook.fromJson(responseSemuaBook.data);

        if (responseDataBook.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          dataBook(responseDataBook.data);
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
