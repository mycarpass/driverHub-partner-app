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
  late String name;
  late String email;
  late bool isPremium;
  late String thumb;
  late String thumbBackground;
  late String document;
  late AddressDto address;

  PartnerDataDto(
      {required this.name, required this.email, required this.isPremium});

  PartnerDataDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    isPremium = json['is_premium'];
    thumb = json["thumb"];
    thumbBackground = json["thumb_background"];
    document = json["document"];
    address = AddressDto.fromJson(json["address"]);
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
