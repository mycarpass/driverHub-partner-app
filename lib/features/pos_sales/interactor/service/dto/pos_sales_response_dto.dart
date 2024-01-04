import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:intl/intl.dart';

class PosSalesResponseDto {
  PosSalesResponseDto({this.posSales = const []});

  List<PosSalesDto> posSales = [];

  PosSalesResponseDto.fromJson(Map<String, dynamic> json) {
    posSales = <PosSalesDto>[];
    json['data'].forEach((v) {
      posSales.add(PosSalesDto.fromJson(v));
    });
  }
}

class PosSalesDto {
  late int id;
  late int saleId;
  late DateTime saleDate;
  late DateTime posSaleDate;
  late bool isMadeContact;
  late PosSalesClient client;
  late PosSaleService service;

  PosSalesDto(
      {required this.id,
      required this.saleDate,
      required this.saleId,
      required this.service,
      required this.posSaleDate,
      required this.isMadeContact,
      required this.client});

  PosSalesDto.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];

      saleId = json['sale_id'];

      isMadeContact = json['made_contact'] ?? false;
      client = PosSalesClient.fromJson(json['client']);
      service = PosSaleService.fromJson(json['service']);
      saleDate = DateFormat('dd/MM/yyyy').parse(json['sale_date']);
      posSaleDate = DateFormat('dd/MM/yyyy').parse(json['after_sale_date']);
    } catch (e) {
      rethrow;
    }
  }
}

class PosSaleService {
  late MoneyValue value;
  late String serviceName;
  late int id;

  PosSaleService(this.value, this.serviceName, this.id);

  PosSaleService.fromJson(Map<String, dynamic> json) {
    value = MoneyValue(json['charged_price']);
    serviceName = json["name"];
    id = json["partner_service_id"];
  }
}

class PosSalesClient {
  late PersonName personName;
  late PhoneValue phone;
  late int id;
  VehicleDto? vehicle;

  PosSalesClient(
      {required this.personName,
      required this.phone,
      required this.id,
      this.vehicle
      // required this.status
      });

  PosSalesClient.fromJson(Map<String, dynamic> json) {
    personName = PersonName(json['name']);
    phone = PhoneValue(value: json['phone']);
    id = json['partner_client_id'];
    vehicle =
        json['vehicle'] != null ? VehicleDto.fromJson(json['vehicle']) : null;
    // status = json['status'];
  }
}
