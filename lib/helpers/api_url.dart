class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listUlasan = baseUrl + 'pariwisata/ulasan';
  static const String createUlasan = baseUrl + 'pariwisata/ulasan';
  static String updateUlasan(int id) {
    return baseUrl + '/pariwisata/ulasan/' + id.toString() + '/update';
  }

  static String showUlasan(int id) {
    return baseUrl + '/pariwisata/ulasan/' + id.toString();
  }

  static String deleteUlasan(int id) {
    return baseUrl + '/pariwisata/ulasan/' + id.toString() + '/delete';
  }
}