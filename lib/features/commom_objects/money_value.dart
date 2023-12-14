import 'package:extended_masked_text/extended_masked_text.dart';

class MoneyValue {
  late double price;
  String priceInReal = "";

  MoneyValue(dynamic priceParam) {
    price = _convertValue(priceParam);
    priceInReal =
        MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: price).text;
  }

  String getStringValueWithoutSimbols() {
    return priceInReal.replaceAll("R", "").replaceAll("\$", "").trim();
  }

  double _convertValue(dynamic priceParam) {
    if (priceParam is int) {
      return priceParam.toDouble();
    }
    return priceParam is String
        ? double.parse(priceParam.replaceAll(".", "").replaceAll(",", "."))
        : priceParam;
  }

  void sum(double value) {
    price = price + value;
    priceInReal =
        MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: price).text;
  }

  void sub(double value) {
    price = price - value;
    priceInReal =
        MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: price).text;
  }
}
