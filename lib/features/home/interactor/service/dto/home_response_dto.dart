class HomeResponseDto {
  HomeData data = HomeData();

  HomeResponseDto.fromJson(Map<String, dynamic> json) {
    data = HomeData.fromJson(json['data']);
  }
  HomeResponseDto();
}

class HomeData {
  late PartnerDataDto partnerData;

  HomeData.fromJson(Map<String, dynamic> json) {
    partnerData = PartnerDataDto.fromJson(json);
  }
  HomeData();
}

class PartnerDataDto {
  late int id;
  late String name;
  late String email;
  late bool isPremium;
  late String thumb;
  late String thumbBackground;
  late String document;
  late String phone;
  late String? cnpj;
  late AddressDto? address;
  late BankAccountDto? bankAccount;
  late bool isAnyServiceRegistered;
  late bool isBankAccountCreated;
  late bool isSubscribed;
  late int daysTrialLeft;

  PartnerDataDto(
      {required this.name, required this.email, required this.isPremium});

  PartnerDataDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    isPremium = json['is_premium'];
    phone = json['phone'];
    thumb = json["thumb"];
    thumbBackground = json["thumb_background"];
    document = json["document"];
    cnpj = json["cnpj"];
    address =
        json["address"] != null ? AddressDto.fromJson(json["address"]) : null;
    bankAccount = json["bank_account"] != null
        ? BankAccountDto.fromJson(json["bank_account"])
        : null;
    isAnyServiceRegistered = json["isAnyServiceRegistered"] ?? false;
    isBankAccountCreated = json["is_bank_account_created"] ?? false;
    isSubscribed = json["is_subscribed"] ?? false;
    daysTrialLeft = json["daysLeftTrial"] ?? 0;
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
    country = json['country'] ?? "Brasil";
    lat = json['lat'];
    lon = json['lon'];
    rawMainAddress = json['raw_main_address'];
    rawSecondaryAddress = json['raw_secondary_address'] ?? "";
  }
}

class BankAccountDto {
  late String id;
  String? agency;
  String? account;
  String? bank;
  String? bankCode;
  String? typeAccount;
  String? typePerson;
  String? cnpj;

  BankAccountDto(
      {required this.id,
      this.agency,
      this.account,
      this.bank,
      this.bankCode,
      this.typeAccount,
      this.typePerson,
      this.cnpj});

  BankAccountDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agency = json['agency'];
    account = json['account'];
    bank = json['bank'];
    bankCode = json['bankCode'];
    typeAccount = json['typeAccount'];
    typePerson = json['typePerson'];
    cnpj = json['cnpj'];
  }

  Map<String, dynamic> toJson() {
    return {
      "agency": agency,
      "account": account,
      "bank": bank,
      "bank_code": bankCode,
      "type_account": typeAccount ?? "CC",
      "type_person": typePerson ?? "PF",
      "cnpj": cnpj
    };
  }
}
