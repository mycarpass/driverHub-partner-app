import 'package:dh_ui_kit/view/extensions/string_extension.dart';

class AuthEntity {
  AuthEntity({required this.email, required this.password});

  String email;
  String password;

  bool isValidPassword() {
    return password.isNotEmpty && password.length >= 6;
  }

  bool isValidEmail() {
    return email.isValidEmail();
  }
}
