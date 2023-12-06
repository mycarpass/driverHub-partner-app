import 'package:driver_hub_partner/features/sales/interactor/service/dto/enum/sales_status.dart';

class SalesResponseDto {
  late List<SalesDto> sales;

  SalesResponseDto.fromJson(Map<String, dynamic> json) {
    sales = [];

    for (var sales in json['sales']) {
      SalesDto sls = SalesDto.fromJson(sales);
      sales.add(sls);
    }
  }

  SalesResponseDto();
}

class SalesDto {
  late int salesId;
  late SalesStatus status;

  SalesDto({
    required this.salesId,
    required this.status,
  });

  SalesDto.fromJson(Map<String, dynamic> json) {
    salesId = json['sales_id'];
    status = _getStatus(json['status']);
  }

  SalesStatus _getStatus(String status) {
    switch (status) {
      case "VERIFIED":
        return SalesStatus.verified;
      case "NOT_VERIFIED":
        return SalesStatus.notVerified;
      default:
        return SalesStatus.notVerified;
    }
  }
}
