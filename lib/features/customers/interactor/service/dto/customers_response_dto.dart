import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class CustomersResponseDto {
  List<CustomerDto> customers = [];

  CustomersResponseDto.fromJson(Map<String, dynamic> json) {
    customers = [];

    for (var customer in json['data']) {
      CustomerDto custmr = CustomerDto.fromJson(customer);
      customers.add(custmr);
    }
  }

  CustomersResponseDto();
}

class CustomerDto {
  late int customerId;
  late CustomerStatus status;
  late String name;
  late String phone;
  late bool isSubscribed;
  late String? spentValue;
  late String? email;
  late String? plate;
  late VehicleDto? vehicle;

  CustomerDto(
      {required this.customerId,
      required this.status,
      required this.name,
      required this.phone,
      required this.isSubscribed,
      this.email,
      this.spentValue,
      this.vehicle,
      this.plate});

  CustomerDto.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    status = _getStatus(json['status'] ?? "NOT_VERIFIED");
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    plate = json['car_licence_plate'];
    isSubscribed = json['isSubscribed'];
    spentValue = json['totalSpent'];
    //  vehicle = VehicleDto.fromJson(json["vehicle"]);
  }

  CustomerStatus _getStatus(String status) {
    switch (status) {
      case "VERIFIED":
        return CustomerStatus.verified;
      case "NOT_VERIFIED":
        return CustomerStatus.notVerified;
      default:
        return CustomerStatus.notVerified;
    }
  }

  String getInitialsName() {
    String firstLetter = name.trim().substring(0, 1).toUpperCase();
    String secondLetter = "";
    List<String> nameSplitted = name.trim().split(" ");
    if (nameSplitted.length >= 2) {
      String secondNameSplitted = nameSplitted[nameSplitted.length - 1];
      secondLetter = secondNameSplitted.substring(0, 1).toUpperCase();
    } else {
      secondLetter = name.trim().substring(1, 2).toUpperCase();
    }
    return "$firstLetter$secondLetter";
  }
}
