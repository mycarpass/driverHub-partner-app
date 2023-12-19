class PhoneValue {
  final String value;

  late String withoutSymbolValue;

  PhoneValue({required this.value}) {
    if (value.contains("(")) {
      withoutSymbolValue = value
          .replaceAll("(", "")
          .replaceAll(")", "")
          .replaceAll("+", "")
          .replaceAll("-", "")
          .replaceAll(" ", "");
    }
  }
}
