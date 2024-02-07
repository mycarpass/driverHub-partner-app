import 'package:driver_hub_partner/features/commom_objects/extensions/date_extensions.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';

class ReceivableDto {
  late MoneyValue totalAmountEarned;
  late MoneyValue totalAmountWithheld;
  late bool isSubscriptionActive;
  late double partnerPlanPrice;
  late List<ReceivableHistoric> historic;
  String actualMonth = "";

  ReceivableDto.fromJson(Map<String, dynamic> json) {
    totalAmountEarned = MoneyValue(json["data"]['total_amount_earned']);
    totalAmountWithheld = MoneyValue(json["data"]['total_amount_withheld']);
    isSubscriptionActive =
        json["data"]['partner_subscription_status'] == "ACTIVE";
    partnerPlanPrice = json["data"]['partner_plan_price'];
    if (json["data"]['historic'] != null) {
      historic = <ReceivableHistoric>[];
      json["data"]['historic'].forEach((v) {
        historic.add(ReceivableHistoric.fromJson(v));
      });
    }

    actualMonth = "${DateTime.now().getRawMonthName()}/${DateTime.now().year}";
  }

  double getPercentToActive() {
    var x = (totalAmountEarned.price * 100) / partnerPlanPrice;
    var toDec = (x / 100);
    return toDec > 1.0 ? 1.0 : toDec;
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
}
