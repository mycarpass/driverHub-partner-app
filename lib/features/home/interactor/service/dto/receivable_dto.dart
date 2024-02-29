import 'package:driver_hub_partner/features/commom_objects/extensions/date_extensions.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';

class ReceivableDto {
  late MoneyValue totalAmountEarned;
  late MoneyValue totalAmountWithheld;
  late bool isSubscriptionActive;
  late bool isSubscriptionEnabled;

  late String status;
  late MoneyValue partnerPlanPrice;
  late List<ReceivableHistoric> historic;
  String actualMonth = "";

  ReceivableDto.fromJson(Map<String, dynamic> json) {
    try {
      actualMonth =
          "${DateTime.now().getRawMonthName()}/${DateTime.now().year}";
      totalAmountEarned = MoneyValue(json["data"]['total_amount_earned']);
      totalAmountWithheld = MoneyValue(json["data"]['total_amount_withheld']);
      status = _getAccountStatus(json["data"]['partner_subscription_status']);

      String rawStatus = json["data"]['partner_subscription_status'];

      isSubscriptionActive = rawStatus == "ACTIVE";
      isSubscriptionEnabled = rawStatus == "ACTIVE" || rawStatus == "PENDING";
      partnerPlanPrice = MoneyValue(json["data"]['partner_plan_price']);
      if (json["data"]['historic'] != null) {
        historic = <ReceivableHistoric>[];
        json["data"]['historic'].forEach((v) {
          historic.add(ReceivableHistoric.fromJson(v));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String getPercentToUI() {
    var x = (totalAmountWithheld.price * 100) / partnerPlanPrice.price;
    return "${x.round()}%";
  }

  double getPercentToActive() {
    var x = (totalAmountWithheld.price * 100) / partnerPlanPrice.price;
    var toDec = (x / 100);
    return toDec > 1.0 ? 1.0 : toDec;
  }

  String _getAccountStatus(String status) {
    switch (status) {
      case "ACTIVE":
        return "Ativa";
      case "PENDING":
        return "Pendente";
      case "BLOCKED":
        return "Inativa";
      default:
        return "Inativa";
    }
  }
}

class ReceivableHistoric {
  late int scheduleId;
  late String scheduledDate;
  late String forecastDate;
  late MoneyValue amountEarnedFromScheduleCents;
  late MoneyValue amountWithheldForSignatureCents;

  ReceivableHistoric.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    scheduledDate = json['scheduled_date'];
    forecastDate = json['forecast_date'];
    amountEarnedFromScheduleCents =
        MoneyValue(json['amount_earned_from_schedule_cents']);
    amountWithheldForSignatureCents =
        MoneyValue(json['amount_withheld_for_signature_cents']);
  }

  bool isOnlyDebitOperation() {
    return amountEarnedFromScheduleCents.price == 0 &&
        amountWithheldForSignatureCents.price > 0;
  }

  bool isOnlyCreditOperation() =>
      amountWithheldForSignatureCents.price == 0 &&
      amountEarnedFromScheduleCents.price > 0;

  bool isCreditAndDebitOperation() =>
      amountWithheldForSignatureCents.price > 0 &&
      amountEarnedFromScheduleCents.price > 0;
}
