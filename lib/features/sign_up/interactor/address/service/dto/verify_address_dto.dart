class VerifyAddressDto {
  final double lat;
  final double lon;

  VerifyAddressDto({required this.lat, required this.lon});

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lon": lon,
    };
  }
}
