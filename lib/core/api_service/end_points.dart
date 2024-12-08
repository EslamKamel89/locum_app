class EndPoint {
  static const String baseUrl = "http://192.168.1.6/api";
  static String prayerTimes(String date) {
    return "https://api.aladhan.com/v1/timings/$date";
  }
}
