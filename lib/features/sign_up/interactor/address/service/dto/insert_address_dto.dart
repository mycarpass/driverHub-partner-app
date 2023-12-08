class InsertAddressDto {
  double? lat;
  double? lon;
  final String mainAddress;
  final String secondaryAddress;
  final String placeId;
  final String reference;
  final String complement;

  InsertAddressDto({
    this.lat,
    this.lon,
    this.complement = "",
    required this.mainAddress,
    required this.secondaryAddress,
    required this.placeId,
    required this.reference,
  });

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lon": lon,
      "main_address": mainAddress,
      "secondary_address": secondaryAddress,
      "place_id": placeId,
      "reference": reference,
      "complement": complement
    };
  }
}
