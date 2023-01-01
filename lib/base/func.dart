import 'package:intl/intl.dart';

class BaseFunc {
  static String rupiah({required var money}) {
    NumberFormat format = NumberFormat.currency(
      locale: "id",
    );
    String m = format.format(money);
    return m.substring(0, m.length - 3);
  }
}
