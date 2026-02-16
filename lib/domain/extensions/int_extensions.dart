import 'package:intl/intl.dart' show NumberFormat;

extension IntExtensions on int {
  String formatPrice({String locale = "pt_BR", String symbol = "R\$"}) =>
      NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: 2,
      ).format(this / 100);
}
