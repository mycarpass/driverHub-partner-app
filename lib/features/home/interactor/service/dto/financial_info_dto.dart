import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:flutter/material.dart';

class FinancialInfoDto {
  late Data data;

  FinancialInfoDto.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late AccountInfo accountInfo;
  List<Transactions>? transactions;

  Data.fromJson(Map<String, dynamic> json) {
    accountInfo = AccountInfo.fromJson(json['account_info']);

    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }
}

class AccountInfo {
  late MoneyValue balance;
  late MoneyValue receivableBalance;
  late MoneyValue balanceAvailableForWithdraw;
  late MoneyValue volumeThisMonth;
  late MoneyValue volumeLastMonth;
  late int totalActiveSubscriptions;

  AccountInfo.fromJson(Map<String, dynamic> json) {
    balance = MoneyValue((removeBrl(json['balance'])));
    receivableBalance = json['receivable_balance'] != null
        ? MoneyValue(removeBrl(json['receivable_balance']))
        : MoneyValue("0,0");
    balanceAvailableForWithdraw = json['balance_available_for_withdraw'] != null
        ? MoneyValue(removeBrl(json['balance_available_for_withdraw']))
        : MoneyValue("0,0");
    volumeThisMonth = MoneyValue(removeBrl(json['volume_this_month']));
    volumeLastMonth = MoneyValue(removeBrl(json['volume_last_month']));
    totalActiveSubscriptions = json['total_active_subscriptions'];
  }

  String removeBrl(String value) {
    if (value.contains("BRL")) {
      return value.split(" ")[0];
    }

    return value.split(" ")[1];
  }
}

class Transactions {
  late MoneyValue amount;
  late int amountCents;
  late String type;
  late String description;
  late String reference;
  late String referenceType;
  late String balance;
  late int balanceCents;
  late String entryDate;
  late String? payerName;
  late String? customerName;
  late String? customerRef;
  late Icon icon;
  late Color backgroundColor;
  late Color textColor;

  String removeBrl(String value) {
    if (value.contains("BRL")) {
      return value.split(" ")[0];
    }

    return value.split(" ")[1];
  }

  Transactions.fromJson(Map<String, dynamic> json) {
    amount = MoneyValue(removeBrl(json['amount']));
    amountCents = json['amount_cents'];
    type = json['type'];
    description = json['description'];
    reference = json['reference'];
    referenceType = json['reference_type'];
    balance = json['balance'];
    balanceCents = json['balance_cents'];
    entryDate = json['entry_date'];
    payerName = json['payer_name'];
    customerName = json['customer_name'];
    customerRef = json['customer_ref'];

    icon = json["type"] == "credit"
        ? const Icon(
            Icons.arrow_forward_outlined,
            color: AppColor.secondaryColor,
          )
        : json["type"] == "tax"
            ? const Icon(
                Icons.attach_money,
                color: AppColor.secondaryColor,
              )
            : const Icon(
                Icons.arrow_back_outlined,
                color: AppColor.accentColor,
              );

    backgroundColor = type == "credit"
        ? Colors.transparent
        : type == "tax"
            ? AppColor.errorColor
            : AppColor.accentColor;

    textColor = type == "credit" ? AppColor.whiteColor : AppColor.blackColor;
  }
}
