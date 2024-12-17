import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formateDateToArabic(DateTime dateTime) {
  initializeDateFormatting();
  Intl.defaultLocale = 'en';
  // Intl.initializeDateFormatting

  String formattedDate = DateFormat('EEEE d MMMM y', 'ar_SA').format(dateTime);
  return formattedDate;
}

String formatDateForApi(DateTime dateTime) {
  String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(dateTime);
  formattedDate;
  return formattedDate;
}
