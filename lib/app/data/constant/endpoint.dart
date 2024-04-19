class Endpoint {
  static const String baseUrlApi =
      // "http://192.168.4.134:8000/api/users/";
      // "http://192.168.86.229:8000/api/users/";
      "http://192.168.137.1:8000/api/users/";

  // Authenticated
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String updateProfile = "${baseUrlApi}update/profile";
  static const String getDataProfile = "${baseUrlApi}get-profile";

  // Buku
  static const String buku = baseUrlApi;
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String kategoriBuku = "${baseUrlApi}kategori";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String searchBook = "${baseUrlApi}buku/search";
  static const String bukuPopular = "${baseUrlApi}popular/buku";
  static const String bukuByKategori = "${baseUrlApi}buku/kategori";

  // Koleksi Buku
  static const String koleksiBuku = "${baseUrlApi}koleksi";
  static const String deleteKoleksi = "${baseUrlApi}";

  // Peminjaman
  static const String historyPeminjaman = "${baseUrlApi}pinjam";
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";

  // Ulasan
  static const String ulasanBuku = "${baseUrlApi}ulasan";
}