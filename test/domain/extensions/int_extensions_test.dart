import 'package:flutter_test/flutter_test.dart';
import 'package:pdv/domain/extensions/int_extensions.dart';

void main() {
  test(r'formatPrice should return R$ 1,00 when price is 100', () {
    int price = 100;
    String expected =  'R\$\u00A0\1,00';

    expect(price.formatPrice(), expected);
  });


  test(r'formatPrice should return 1,00 when price is 100 and symbol is empty', () {
    int price = 100;
    String expected =  '\u00A0\1,00';

    expect(price.formatPrice(symbol: ""), expected);
  });
}