import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class CustomersResponseDto {
  late List<CustomerDto> customers;

  CustomersResponseDto.fromJson(Map<String, dynamic> json) {
    customers = [];

    for (var customer in json['customers']) {
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
  late String? email;
  late String? plate;
  late VehicleDto? vehicle;

  CustomerDto(
      {required this.customerId,
      required this.status,
      required this.name,
      required this.phone,
      this.email,
      this.vehicle,
      this.plate});

  CustomerDto.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    status = _getStatus(json['status']);
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    plate = json['plate'];
    vehicle = VehicleDto.fromJson(json["vehicle"]);
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
}
