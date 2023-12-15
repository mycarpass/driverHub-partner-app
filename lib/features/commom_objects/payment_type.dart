enum PaymentType {
  creditCard("Cartão de crédito"),
  pix("Pix"),
  paper("Dinheiro"),
  uniformed("Não Informado");

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
        return PaymentType.uniformed;
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
}
