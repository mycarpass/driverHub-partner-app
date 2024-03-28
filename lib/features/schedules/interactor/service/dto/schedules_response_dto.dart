import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/enum/schedule_status.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SchedulesResponseDto {
  SchedulesData data = SchedulesData();

  SchedulesResponseDto.fromJson(Map<String, dynamic> json) {
    data = SchedulesData.fromJson(json);
  }
  SchedulesResponseDto();
}

class SchedulesData {
  late List<ScheduleDataDto> schedules;
  List<ScheduleDataDto> schedulesPending = [];
  List<ScheduleDataDto> schedulesAccepted = [];
  List<ScheduleDataDto> schedulesDone = [];

  SchedulesData.fromJson(Map<String, dynamic> json) {
    schedules = [];
    schedulesPending = [];
    schedulesAccepted = [];
    schedulesDone = [];
    for (var schedule in json['data']) {
      ScheduleDataDto sch = ScheduleDataDto.fromJson(schedule);

      if (sch.status != ScheduleStatus.canceled &&
          sch.status != ScheduleStatus.expired &&
          sch.status != ScheduleStatus.refused) {
        schedules.add(sch);
      }
      if (sch.status == ScheduleStatus.pending ||
          sch.status == ScheduleStatus.paymentPending ||
          sch.status == ScheduleStatus.newHourSuggested) {
        schedulesPending.add(sch);
      } else if (sch.status == ScheduleStatus.waitingToWork ||
          sch.status == ScheduleStatus.inProgress) {
        schedulesAccepted.add(sch);
      } else if (sch.status == ScheduleStatus.finished) {
        schedulesDone.add(sch);
      }
    }
  }

  List<ScheduleDataDto> filterByDate(DateTime date) {
    return schedules
        .where(
          (element) =>
              element.scheduleDateTime.month == date.month &&
              element.scheduleDateTime.year == date.year,
        )
        .toList();
  }

  SchedulesData();
}

class CheckListPhoto {
  final int id;

  final String description;
  final XFile file;
  String networkPath = "";

  CheckListPhoto(
      {required this.id,
      required this.file,
      required this.description,
      this.networkPath = ""});

  Map<String, dynamic> toJson() {
    return {"id": id, "image": file, "description": description};
  }

  factory CheckListPhoto.fromJson(Map<String, dynamic> json) {
    return CheckListPhoto(
        id: json["id"],
        description: json["description"] ?? "",
        file: XFile(""),
        networkPath: json["image_url"]);
  }

  Future<FormData> toSavePhotoMap() async {
    return FormData.fromMap({
      "id": id,
      "image": await MultipartFile.fromFile(file.path),
      "description": description
    });
  }
}

class ScheduleDataDto {
  late int scheduleId;
  late ScheduleStatus status;
  late String statusFriendly;
  late String origin;
  late String originDelivery;
  late bool delivery;
  late String? paymentStatus;
  late String? totalAmountPayable;
  late String? paymentType;
  late String scheduleDate;
  late DateTime scheduleDateTime;
  late List<ScheduleTimeSuggestionDto> timeSuggestions;
  late ScheduleSelectedServicesDto selectedServices;
  late ClientScheduleDto client;
  late String? serviceType;
  late AddressDto? userAddress;
  late PixScheduleDto? pix;
  late VehicleDto? vehicle;
  late PartnerScheduleDto? partner;
  List<CheckListPhoto> photoList = [];
  late String? message;

  ScheduleDataDto(
      {required this.scheduleId,
      required this.status,
      required this.origin,
      required this.originDelivery,
      required this.delivery,
      required this.paymentStatus,
      required this.totalAmountPayable,
      required this.paymentType,
      required this.scheduleDate,
      required this.timeSuggestions,
      required this.selectedServices,
      this.serviceType,
      required this.userAddress,
      this.vehicle,
      this.pix});

  ScheduleDataDto.fromJson(Map<String, dynamic> json) {
    try {
      scheduleId = json['schedule_id'];
      status = _getStatus(json['status']);
      origin = json['origin'];
      originDelivery = json['origin_delivery'];
      delivery = json['delivery'];
      paymentStatus = json['payment_status'];
      totalAmountPayable = json['total_amount_payable'];
      paymentType = json['payment_type'];
      scheduleDate = json['scheduled_date'];
      scheduleDateTime = DateFormat('dd/MM/yyyy').parse(json['scheduled_date']);
      timeSuggestions = [];
      for (var time in json['time_suggestions']) {
        timeSuggestions.add(ScheduleTimeSuggestionDto.fromJson(time));
      }

      for (var photo in json['checklist_photos']) {
        photoList.add(CheckListPhoto.fromJson(photo));
      }

      selectedServices =
          ScheduleSelectedServicesDto.fromJson(json['selected_services']);
      userAddress = json["user_address"] != null
          ? AddressDto.fromJson(json["user_address"])
          : null;
      serviceType = json["service_type"];
      client = ClientScheduleDto.fromJson(json["client"]);
      pix = PixScheduleDto.fromJson(json["pix"]);
      vehicle =
          json["vehicle"] != null ? VehicleDto.fromJson(json["vehicle"]) : null;
      statusFriendly = _getUserFriendlyStatus(json["status"]);
      partner = json['partner'] != null
          ? PartnerScheduleDto.fromJson(json['partner'])
          : null;
      message = json['message'];
    } catch (e) {
      rethrow;
    }
  }

  bool isPhotoCheckListFull() {
    return photoList.length == 10;
  }

  IconData getIcon() {
    switch (status) {
      case ScheduleStatus.pending:
        return Icons.access_time;
      case ScheduleStatus.inProgress:
        return Icons.car_crash_outlined;
      case ScheduleStatus.waitingToWork:
        return Icons.hourglass_bottom;
      case ScheduleStatus.finished:
        return Icons.check;
      case ScheduleStatus.newHourSuggested:
        return Icons.access_time;
      default:
        return Icons.cancel_outlined;
    }
  }

  List<ScheduleTimeSuggestionDto> getTimeSuggestions() {
    List<ScheduleTimeSuggestionDto> suggestions = [];
    for (var time in timeSuggestions) {
      if (!time.byPartner) {
        suggestions.add(time);
      }
    }
    return suggestions;
  }

  ScheduleTimeSuggestionDto fetchInitialTimeSuggestion() {
    for (var time in timeSuggestions) {
      if (time.isSelected) {
        return time;
      }
    }

    for (var timeNotSelected in timeSuggestions) {
      if (!timeNotSelected.byPartner) {
        return timeNotSelected;
      }
    }

    return timeSuggestions.first;
  }

  ScheduleStatus _getStatus(String status) {
    switch (status) {
      case "PENDING":
        return ScheduleStatus.pending;
      case "ACCEPTED":
        return ScheduleStatus.waitingToWork;
      case "IN_PROGRESS":
        return ScheduleStatus.inProgress;
      case "DONE":
        return ScheduleStatus.finished;
      case "CANCELLED":
        return ScheduleStatus.canceled;
      case "REFUSED":
        return ScheduleStatus.refused;
      case "EXPIRED":
        return ScheduleStatus.expired;
      case "NEW_DATE_REQUESTED":
        return ScheduleStatus.newHourSuggested;
      case "PAYMENT_PENDING":
        return ScheduleStatus.paymentPending;
      default:
        return ScheduleStatus.expired;
    }
  }

  String _getUserFriendlyStatus(String status) {
    switch (status) {
      case "PENDING":
        return "Confirme o horário";
      case "ACCEPTED":
        return "Aguardando atendimento";
      case "IN_PROGRESS":
        return "Em andamento";
      case "DONE":
        return "Concluído";
      case "CANCELLED":
        return "Cancelado";
      case "REFUSED":
        return "Recusado";
      case "EXPIRED":
        return "Confirmação expirada";
      case "PAYMENT_PENDING":
        return "Aguardando pagamento";
      case "ACCEPTED_PAYMENT_PENDING":
        return "Aguardando pagamento";
      case "NEW_DATE_REQUESTED":
        return "Aguardando cliente";
      case "READY_TO_CHECK_IN":
        return "Aguardando check-in do cliente";
      default:
        return "Status desconhecido";
    }
  }

  Color fetchTagColor() {
    if (status == ScheduleStatus.paymentPending ||
        status == ScheduleStatus.pending) {
      return AppColor.warningColor;
    } else if (status == ScheduleStatus.finished) {
      return AppColor.successColor;
    } else if (status == ScheduleStatus.inProgress) {
      return AppColor.accentColor;
    } else if (status == ScheduleStatus.waitingToWork ||
        status == ScheduleStatus.newHourSuggested) {
      return Colors.blueGrey;
    }
    return AppColor.borderColor;
  }

  bool canShowSelectedHour() {
    return status == ScheduleStatus.waitingToWork ||
        status == ScheduleStatus.inProgress ||
        status == ScheduleStatus.finished;
  }

  bool canTalkWithClient() {
    return status == ScheduleStatus.pending ||
        status == ScheduleStatus.waitingToWork ||
        status == ScheduleStatus.inProgress;
  }

  bool serviceIsNotAccepted() {
    return status == ScheduleStatus.pending;
  }

  bool waitingClient() {
    return status == ScheduleStatus.newHourSuggested;
  }

  bool isNotShowAction() {
    return status == ScheduleStatus.newHourSuggested ||
        status == ScheduleStatus.paymentPending ||
        status == ScheduleStatus.finished;
  }

  String actionText() {
    switch (status) {
      case ScheduleStatus.pending:
        return "Aceitar agendamento";
      case ScheduleStatus.waitingToWork:
        return "Iniciar serviço";
      case ScheduleStatus.inProgress:
        return "Finalizar serviço";
      default:
        return "";
    }
  }

  String getSelectecHour() {
    try {
      return timeSuggestions.firstWhere((element) => element.isSelected).time;
    } catch (e) {
      return timeSuggestions.first.time;
    }
  }
}

class ScheduleTimeSuggestionDto {
  late int id;
  late String time;
  late bool isSelected;
  late bool byPartner;
  late String? date;

  ScheduleTimeSuggestionDto(
      {required this.id,
      required this.time,
      required this.isSelected,
      required this.byPartner});

  ScheduleTimeSuggestionDto.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    time = json["time"];
    isSelected = json["is_selected"];
    byPartner = json["by_partner"];
    date = json["date"];
  }
}

class ScheduleSelectedServicesDto {
  late List<ItemScheduleServiceDto> items;
  late String totalPrice;

  ScheduleSelectedServicesDto({required this.items, required this.totalPrice});

  ScheduleSelectedServicesDto.fromJson(Map<String, dynamic> json) {
    items = [];
    for (var item in json["items"]) {
      items.add(ItemScheduleServiceDto.fromJson(item));
    }
    totalPrice = json["total_price"];
  }
}

class ItemScheduleServiceDto {
  late int priceId;
  late String price;
  late String service;
  late String minTime;
  late String maxTime;
  late List<dynamic> includedServices;

  ItemScheduleServiceDto(
      {required this.priceId,
      required this.price,
      required this.service,
      required this.minTime,
      required this.maxTime,
      required this.includedServices});

  ItemScheduleServiceDto.fromJson(Map<String, dynamic> json) {
    priceId = json["price_id"];
    price = json["price"];
    service = json["service"];
    minTime = json["min_time"];
    maxTime = json["max_time"];
    includedServices = json["included_services"] ?? [];
  }
}

class ClientScheduleDto {
  late String name;
  late String phone;
  late int id;

  ClientScheduleDto({
    required this.name,
    required this.phone,
    required this.id,
  });

  ClientScheduleDto.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "Não carregado";
    phone = json["phone"] ?? "Não carregado";
    id = json["id"] ?? 0;
  }

  String getFirstAndLastName() {
    if (name.split(" ").length > 1) {
      return "${getUserFirstName()} ${getUserLastName()}";
    } else {
      return getUserFirstName();
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

  String getUserFirstName() {
    return name.split(" ").first;
  }

  String getUserLastName() {
    return name.split(" ").last;
  }
}

class PartnerScheduleDto {
  late String name;
  String? logo;

  PartnerScheduleDto({
    required this.name,
    this.logo,
  });

  PartnerScheduleDto.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    logo = json["logo"];
  }
}

class PixScheduleDto {
  late String? pixCode;
  late String? invoiceId;
  late int scheduleId;

  PixScheduleDto({
    this.pixCode,
    this.invoiceId,
    required this.scheduleId,
  });

  PixScheduleDto.fromJson(Map<String, dynamic> json) {
    pixCode = json["pix_code"];
    invoiceId = json["invoice_id"];
    scheduleId = json["schedule_id"];
  }
}

class AddressDto {
  late int id;
  late bool isSelected;
  late String type;
  String? zipcode;
  String? address;
  String? number;
  String? neighborhood;
  String? complement;
  String? city;
  String? state;
  String? country;
  late String lat;
  late String lon;
  late String rawMainAddress;
  late String rawSecondaryAddress;

  AddressDto(
      {required this.id,
      required this.isSelected,
      required this.type,
      required this.zipcode,
      this.address,
      this.number,
      this.neighborhood,
      this.complement,
      this.city,
      this.state,
      this.country,
      required this.lat,
      required this.lon,
      required this.rawMainAddress,
      required this.rawSecondaryAddress});

  AddressDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSelected = json['is_selected'];
    type = json['type'];
    zipcode = json['zipcode'];
    address = json['address'];
    number = json['number'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    rawMainAddress = json['raw_main_address'];
    rawSecondaryAddress = json['raw_secondary_address'];
  }
}

class VehicleDto {
  late int id;
  String? name;
  late String make;
  late String model;
  late CarBodyType bodyType;
  String? plate;
  String? nickname;

  VehicleDto({
    required this.id,
    required this.name,
    required this.make,
    required this.model,
    required this.bodyType,
    required this.plate,
    this.nickname,
  });

  VehicleDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['make'];
    model = json['model'];
    nickname = json['nickname'];
    bodyType = getCategory(json['body_type']);
    // plate = json['license_plate'];
  }
}

CarBodyType getCategory(dynamic category) {
  switch (category) {
    case "HATCHBACK":
    case 0:
      return CarBodyType.hatchback;
    case "SEDAN":
    case 1:
      return CarBodyType.sedan;
    case "SUV":
    case 2:
      return CarBodyType.suv;
    case "PICKUP":
    case 3:
      return CarBodyType.pickup;
    case "HIGH_VALUE_PICKUP":
      // case 0:

      return CarBodyType.ram;
    default:
      return CarBodyType.sedan;
  }
}

/*
//  "status": "NEW_DATE_REQUESTED",


{
            "schedule_id": 2,
            "status": "IN_PROGRESS",
            "origin": "LOOSE",
            "origin_delivery": "LOOSE",
            "delivery": true,
            "cancel_tax": "0,00",
            "delivery_cost": "5,00",
            "payment_status": "PAID",
            "total_amount_payable": "60,00",
            "total_services_signature_partner": "0,00",
            "total_services_signature_driver_hub": "0,00",
            "delivery_cost_to_signature": "0,00",
            "payment_type": "CREDIT_CARD",
            "scheduled_date": "11/09/2023",
            "created_at": "11/09/23",
            "last_update": "11/09/23 11:41",
            "time_suggestions": [
              {
                "id": 1,
                "time": "11:45",
                "is_selected": true,
                "by_partner": false,
                "date": null
              }
            ],
            "selected_services": {
              "items": [
                {
                  "price_id": 1,
                  "price": "60,00",
                  "service": "Lavada Simples",
                  "min_time": "02h00",
                  "max_time": "03h00",
                  "included_services": []
                }
              ],
              "total_price": "60,00"
            },
            "partner": {
              "id": 3,
              "name": "Shark Tale",
              "email": "sharktale@driverhub.com",
              "document": "32.597.137/0001-61",
              "first_access": true,
              "is_premium": false,
              "thumb": "",
              "thumb_background": "",
              "phone": "",
              "address": {
                "id": 17,
                "is_selected": true,
                "type": "NONE",
                "zipcode": null,
                "address": "Ledawegstraat",
                "number": " 12",
                "neighborhood": "Willemstad",
                "complement": null,
                "city": "Curaçao",
                "state": "SP",
                "country": " Curaçao",
                "lat": "12.1436659",
                "lon": "-68.8898858",
                "raw_main_address": "Ledawegstraat, 12",
                "raw_secondary_address": "Willemstad, Curaçao - SP, Curaçao"
              }
            },
            "service_type": null,
            "client": {
              "name": "Jhon Test",
              "phone": "(11) 99852-1971"
            },
            "pix": {
              "pix_code": null,
              "invoice_id": null,
              "schedule_id": 2
            },
            "vehicle": {
              "id": 2,
              "name": "",
              "make": "FIAT",
              "model": "UNO",
              "color": "BRANCA",
              "body_type": "HATCHBACK",
              "nickname": "UNO",
              "year": "2023",
              "license_plate": "ABC1234",
              "thumb": "",
              "is_selected": true,
              "desvalorizometro": null,
              "monthReference": null,
              "fipeValue": null,
              "fipePriceStatus": null,
              "base_64_image": null
            },
            "user_address": {
              "id": 2,
              "is_selected": false,
              "type": "NONE",
              "zipcode": null,
              "address": "Ledawegstraat",
              "number": "22",
              "neighborhood": "Willemstad",
              "complement": null,
              "city": "Curaçao",
              "state": "SP",
              "country": " Curaçao",
              "lat": "12.1439188",
              "lon": "-68.890587",
              "raw_main_address": "Hecubaweg, 22",
              "raw_secondary_address": "Willemstad, Curaçao - SP, Curaçao"
            },
            "rating": null
          }

  */