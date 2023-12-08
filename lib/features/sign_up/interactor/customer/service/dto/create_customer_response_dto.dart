class CreateCustomerReponseDto {
  final String token;

  CreateCustomerReponseDto(this.token);

  static CreateCustomerReponseDto fromJson(Map<String, dynamic> json) {
    return CreateCustomerReponseDto(json["token"]);
  }
}
