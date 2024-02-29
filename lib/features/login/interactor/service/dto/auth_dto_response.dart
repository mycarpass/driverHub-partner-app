class AuthDtoResponse {
  final String token;
  final String role;

  AuthDtoResponse(this.token, this.role);

  static AuthDtoResponse fromJson(Map<String, dynamic> json) {
    return AuthDtoResponse(json["access_token"], json["role"]);
  }
}
