class VerifyAddressReponseDto {
  final bool isAvailable;

  VerifyAddressReponseDto(this.isAvailable);

  static VerifyAddressReponseDto fromJson(Map<String, dynamic> json) {
    return VerifyAddressReponseDto(json["isAvailable"]);
  }
}
