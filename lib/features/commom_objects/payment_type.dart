import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

enum PaymentType {
  creditCard("Cartão de crédito"),
  pix("Pix"),
  paper("Dinheiro");

  const PaymentType(this.value);
  final String value;

  static PaymentType fromString(String stringName) {
    switch (stringName) {
      case "CREDIT CARD":
        return PaymentType.creditCard;
      case "PIX":
        return PaymentType.pix;
      case "CASH":
        return PaymentType.paper;
      default:
        return PaymentType.creditCard;
    }
  }

  int toInt() {
    switch (this) {
      case PaymentType.creditCard:
        return 1;
      case PaymentType.pix:
        return 2;
      case PaymentType.paper:
        return 3;
      default:
        return 1;
    }
  }

  IconData iconPaymentType() {
    switch (this) {
      case PaymentType.creditCard:
        return Icons.credit_card;
      case PaymentType.pix:
        return Icons.pix;
      case PaymentType.paper:
        return Icons.money;
      default:
        return CustomIcons.dhCanceled;
    }
  }
}
