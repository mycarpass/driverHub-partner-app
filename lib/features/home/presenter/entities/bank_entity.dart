import 'package:animated_custom_dropdown/custom_dropdown.dart';

class BankEntity with CustomDropdownListFilter {
  final String name;
  final String code;
  final String agencyMask;
  const BankEntity(this.code, this.name, this.agencyMask);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
