class FetchListAddressResponseDto {
  List<FetchAddressReponseDto> addressList;
  FetchListAddressResponseDto({required this.addressList});

  static FetchListAddressResponseDto fromJson(dynamic jsonList) {
    List<FetchAddressReponseDto> list = [];
    for (var address in jsonList["data"]) {
      list.add(FetchAddressReponseDto.fromJson(address));
    }
    return FetchListAddressResponseDto(addressList: list);
  }
}

class FetchAddressReponseDto {
  final int id;
  final String mainAddress;
  final String secondaryAddress;
  final String lat;
  final String lon;
  final bool isSelected;
  final AddressType type;

  FetchAddressReponseDto(
      {required this.id,
      required this.mainAddress,
      required this.secondaryAddress,
      required this.lat,
      required this.lon,
      required this.isSelected,
      required this.type});

  static FetchAddressReponseDto fromJson(Map<String, dynamic> json) {
    return FetchAddressReponseDto(
        id: json["id"],
        mainAddress: json["raw_main_address"],
        secondaryAddress: json["raw_secondary_address"],
        lat: json["lat"],
        lon: json["lon"],
        isSelected: json["is_selected"],
        type: AddressType.fromJson(json["type"]));
  }
}

enum AddressType {
  home,
  work,
  none;

  String toJson() => name;
  static AddressType fromJson(String json) => values.byName(json.toLowerCase());
}
