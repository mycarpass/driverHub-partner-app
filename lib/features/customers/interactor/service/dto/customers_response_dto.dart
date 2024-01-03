import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

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
  late PersonName name;
  late PhoneValue phone;
  late bool isSubscribed;
  late MoneyValue? spentValue;
  late int? quantityDoneSales;
  late String? email;
  late String? plate;
  VehicleDto? vehicle;
  CarBodyType? manualBodyTypeSelected;

  CustomerDto(
      {required this.customerId,
      required this.status,
      required this.name,
      required this.phone,
      required this.isSubscribed,
      this.email,
      this.spentValue,
      this.vehicle,
      this.quantityDoneSales,
      this.plate});

  String getPlate() {
    if (plate != null) {
      return plate!;
    } else {
      return "Placa não cadastrada";
    }
  }

  bool isVehicleNull() {
    ///TODO add manual carbodyType
    return customerId != 0 &&
        (vehicle == null ||
            (vehicle?.id == 0 && manualBodyTypeSelected == null));
  }

  CustomerDto.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    status = _getStatus(json['status'] ?? "NOT_VERIFIED");
    name = PersonName(json['name']);
    phone = PhoneValue(value: json['phone']);
    email = json['email'];
    plate = json['car_licence_plate'];
    isSubscribed = json['isSubscribed'];
    spentValue = MoneyValue(json['totalSpent']);
    quantityDoneSales = json['quantityDoneSales'] ?? 0;
    if (json["vehicle"] != null && json["vehicle"] is List) {
      for (var vehicle in json["vehicle"]) {
        vehicle = VehicleDto.fromJson(vehicle);
      }
    } else {
      json["vehicle"] != null
          ? vehicle = VehicleDto.fromJson(json["vehicle"])
          : vehicle = null;
    }
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
