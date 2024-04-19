import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/user/response_data_profile.dart';
import '../../../data/provider/api_provider.dart';

class UpdateprofileController extends GetxController with StateMixin{

  var detailProfile = Rxn<DataUser>();
  final loading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController namalengkapController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataUser() async {
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(Endpoint.getDataProfile);

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDataProfile responseBuku = ResponseDataProfile.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          detailProfile(responseBuku.data);
          emailController.text = detailProfile.value!.email.toString();
          bioController.text = detailProfile.value!.bio.toString();
          teleponController.text = detailProfile.value!.telepon.toString();
          usernameController.text = detailProfile.value!.username.toString();
          namalengkapController.text = detailProfile.value!.namaLengkap.toString();
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

  updateProfilePost() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var response = await ApiProvider.instance().patch(Endpoint.updateProfile,
            data:
            {
              "Username" : usernameController.text.toString(),
              "Bio" : bioController.text.toString(),
              "NamaLengkap" : namalengkapController.text.toString(),
              "Email" : emailController.text.toString(),
              "NoTelepon" : teleponController.text.toString(),
            }
        );
        if (response.statusCode == 201) {
          String username = usernameController.text.toString();
          _showMyDialog(
                  (){
                Get.back();
                Get.reloadAll();
              },
              "Update Profile Berhasil",
              "Update Profile Akun $username Berhasil",
              "Lanjut");
        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "Update Profile Gagal",
              "Ok"
          );
        }
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data?['Message']}",
              "Ok"
          );
        }
      } else {
        _showMyDialog(
              (){
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
            (){
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
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18.0
                  ),
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18.0
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
}
