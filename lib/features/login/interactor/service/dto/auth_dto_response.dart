class AuthDtoResponse {
  final String token;

  AuthDtoResponse(this.token);

  static AuthDtoResponse fromJson(Map<String, dynamic> json) {
    return AuthDtoResponse(json["access_token"]);
  }
}
