import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

class ServiceEntity with CustomDropdownListFilter {
  int? id;
  String name;
  String? description;
  String? serviceTimeHours;
  String? daysPosSales;
  ServiceCategory category;
  ServiceType type;
  bool isLiveOnApp;
  bool? isSelected = false;
  String? basePrice;
  List<ServiceRequestPrice> prices = [];
  List<AddtionalWashRequest>? additionalWashes;

  ServiceEntity(
    this.id,
    this.name,
    this.description,
    this.serviceTimeHours,
    this.daysPosSales,
    this.category,
    this.type,
    this.isLiveOnApp,
  );

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> jsonPrices = [];
    for (var price in prices) {
      jsonPrices.add(price.toJson());
    }
    if (prices.isNotEmpty) {
      jsonPrices.add({
        "carBodyType": 4,
        "value": prices[1].value.getStringValueWithoutSimbols(),
      });

      jsonPrices.add({
        "carBodyType": 5,
        "value": prices[1].value.getStringValueWithoutSimbols(),
      });

      jsonPrices.add({
        "carBodyType": 6,
        "value": prices[1].value.getStringValueWithoutSimbols(),
      });

      jsonPrices.add({
        "carBodyType": 7,
        "value": prices[2].value.getStringValueWithoutSimbols(),
      });
    }

    List<Map<String, dynamic>> jsonAdditionalWashes = [];
    if (additionalWashes != null) {
      for (var additional in additionalWashes!) {
        jsonAdditionalWashes.add(additional.toJson());
      }
    }

    return {
      "serviceId": id,
      "description": description,
      "time": _fetchTimeHoursInMinutes(),
      "dayPosSales": daysPosSales,
      "isLiveOnApp": isLiveOnApp,
      "prices": jsonPrices,
      "additionalWashes": additionalWashes != null ? jsonAdditionalWashes : null
    };
  }

  int? _fetchTimeHoursInMinutes() {
    if (serviceTimeHours == null || serviceTimeHours == "") {
      return null;
    }
    return int.parse(serviceTimeHours!) * 60;
  }
}

class ServiceRequestPrice {
  CarBodyType carBodyType;
  MoneyValue value;
  int partnerId;

  ServiceRequestPrice(this.carBodyType, this.value, this.partnerId);

  Map<String, dynamic> toJson() {
    var map = {
      "carBodyType": carBodyType.toInt(),
      "value": value.getStringValueWithoutSimbols(),
    };

    return map;
  }
}

class AddtionalWashRequest {
  int id;
  String price;

  AddtionalWashRequest(
    this.id,
    this.price,
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "price": price.replaceAll("R\$", "").trim(),
    };
  }
}
