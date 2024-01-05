import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class ReceiptSaleEntity {
  ReceiptSaleEntity(
      {required this.partnerName,
      required this.customerName,
      required this.saleDate,
      required this.total,
      required this.services,
      this.vehicle,
      this.discount,
      this.subTotal,
      this.partnerLogo});

  String partnerName;
  String customerName;
  String? partnerLogo;
  VehicleDto? vehicle;
  String saleDate;
  MoneyValue total;
  MoneyValue? discount;
  MoneyValue? subTotal;
  List<String> services;

  String getInitialsName() {
    String firstLetter = partnerName.trim().substring(0, 1).toUpperCase();
    String secondLetter = "";
    List<String> nameSplitted = partnerName.trim().split(" ");
    if (nameSplitted.length >= 2) {
      String secondNameSplitted = nameSplitted[nameSplitted.length - 1];
      secondLetter = secondNameSplitted.substring(0, 1).toUpperCase();
    } else {
      secondLetter = partnerName.trim().substring(1, 2).toUpperCase();
    }
    return "$firstLetter$secondLetter";
  }
}
