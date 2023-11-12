class AuthDtoResponse {
  final String token;
  final bool isOnboarded;

  AuthDtoResponse(this.token, this.isOnboarded);

  static AuthDtoResponse fromJson(Map<String, dynamic> json) {
    return AuthDtoResponse(json["access_token"], json["onboarded"]);
  }
}
