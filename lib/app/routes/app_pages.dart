import 'package:get/get.dart';

import '../modules/aboutpage/bindings/aboutpage_binding.dart';
import '../modules/aboutpage/views/aboutpage_view.dart';
import '../modules/bookbykategori/bindings/bookbykategori_binding.dart';
import '../modules/bookbykategori/views/bookbykategori_view.dart';
import '../modules/bookmark/bindings/bookmark_binding.dart';
import '../modules/bookmark/views/bookmark_view.dart';
import '../modules/bookpopular/bindings/bookpopular_binding.dart';
import '../modules/bookpopular/views/bookpopular_view.dart';
import '../modules/buktipeminjaman/bindings/buktipeminjaman_binding.dart';
import '../modules/buktipeminjaman/views/buktipeminjaman_view.dart';
import '../modules/buku/bindings/buku_binding.dart';
import '../modules/buku/views/buku_view.dart';
import '../modules/detailbuku/bindings/detailbuku_binding.dart';
import '../modules/detailbuku/views/detailbuku_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/layout/bindings/layout_binding.dart';
import '../modules/layout/views/layout_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/updateprofile/bindings/updateprofile_binding.dart';
import '../modules/updateprofile/views/updateprofile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: _Paths.LAYOUT,
      page: () => const LayoutView(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARK,
      page: () => const BookmarkView(),
      binding: BookmarkBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BUKU,
      page: () => const BukuView(),
      binding: BukuBinding(),
    ),
    GetPage(
      name: _Paths.DETAILBUKU,
      page: () => const DetailbukuView(),
      binding: DetailbukuBinding(),
    ),
    GetPage(
      name: _Paths.BOOKBYKATEGORI,
      page: () => const BookbykategoriView(),
      binding: BookbykategoriBinding(),
    ),
    GetPage(
      name: _Paths.BUKTIPEMINJAMAN,
      page: () => const BuktipeminjamanView(),
      binding: BuktipeminjamanBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEPROFILE,
      page: () => const UpdateprofileView(),
      binding: UpdateprofileBinding(),
    ),
    GetPage(
      name: _Paths.BOOKPOPULAR,
      page: () => const BookpopularView(),
      binding: BookpopularBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTPAGE,
      page: () => const AboutpageView(),
      binding: AboutpageBinding(),
    ),
  ];
}
