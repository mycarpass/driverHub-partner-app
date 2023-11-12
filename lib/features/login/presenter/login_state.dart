import 'package:dh_state_management/dh_state.dart';

class LoginState extends DHState {}

class LoginLoadingState extends DHState {
  LoginLoadingState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends DHState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends DHState {
  @override
  List<Object> get props => [];
}

class LoginEmailInputErrorState extends DHState {
  final String errorText;

  LoginEmailInputErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class LoginPasswordInputErrorState extends DHState {
  final String errorText;

  LoginPasswordInputErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class LoginErrorState extends DHState {
  final String errorText;

  LoginErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}
