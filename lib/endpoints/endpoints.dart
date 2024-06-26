class Endpoints {
  static String baseURLLive = "http://172.20.10.2:5000";

  // Function to update baseURL
  static void updateBaseURL(String url) {
    baseURLLive = url;
  }

  // Pesanan Endpoints
  static String get createPesanan => "$baseURLLive/api/v1/pesanan/create";
  static String get readPesanan => "$baseURLLive/api/v1/pesanan/read";
  static String get readPesananByUser => "$baseURLLive/api/v1/pesanan/read_by_user";
  static String get updatePesanan => "$baseURLLive/api/v1/pesanan/update";
  static String get deletePesanan => "$baseURLLive/api/v1/pesanan/delete";

  // Pelanggan Endpoints
  static String get readPelanggan => "$baseURLLive/api/v1/pelanggan/read";
  static String get createPelanggan => "$baseURLLive/api/v1/pelanggan/create";
  static String get updatePelanggan => "$baseURLLive/api/v1/pelanggan/update";
  static String get deletePelanggan => "$baseURLLive/api/v1/pelanggan/delete";

  // Auth Endpoints
  static String get dataLogin => "$baseURLLive/api/v1/auth/login";
  static String get register => "$baseURLLive/api/v1/auth/register";
  static String get login => "$baseURLLive/api/v1/protected/data";
  static String get logout => "$baseURLLive/api/v1/auth/logout";

  // User Endpoints
  static String get readUserById => "$baseURLLive/api/v1/user/read_by_user";
  static String get updateUser => "$baseURLLive/api/v1/user/update";
  static String get uploadUserPhoto => "$baseURLLive/api/v1/user/upload";
  static String get getUserPhoto => "$baseURLLive/api/v1/user/photo";
}
