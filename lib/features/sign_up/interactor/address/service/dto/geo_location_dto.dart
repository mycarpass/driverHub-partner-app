class GeoLocationResponseDto {
  GeoCoords? coords;
  String title;
  final String description;
  final String placeId;
  final String reference;

  GeoLocationResponseDto(
      {required this.title,
      required this.description,
      required this.placeId,
      required this.reference});

  static List<GeoLocationResponseDto> fromJson(dynamic listAddress) {
    List<GeoLocationResponseDto> addressList = [];
    for (var address in listAddress) {
      addressList.add(GeoLocationResponseDto(
          reference: address["reference"],
          placeId: address["place_id"],
          title: address["structured_formatting"]["main_text"],
          description: address["structured_formatting"]["secondary_text"]));
    }
    return addressList;
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": coords?.lat,
      "lon": coords?.lon,
      "title": title,
      "description": description,
      "reference": reference,
      "placeId": placeId,
    };
  }
}

class GeoCoords {
  final double lat;
  final double lon;

  GeoCoords({required this.lat, required this.lon});

  static GeoCoords fromJson(dynamic map) {
    return GeoCoords(
        lat: map['result']['geometry']['location']['lat'],
        lon: map['result']['geometry']['location']['lng']);
  }
}
