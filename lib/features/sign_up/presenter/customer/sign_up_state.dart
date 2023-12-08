import 'package:dh_state_management/dh_state.dart';

class SignUpInitialState extends DHState {}

class SignUpNextStep extends DHState {
  final int currentStep;

  SignUpNextStep(this.currentStep);

  @override
  List<Object> get props => [currentStep];
}

class SignUpFinishedState extends DHState {
  @override
  List<Object> get props => [];
}

class InputValidationErrorState extends DHState {
  final String errorText;

  InputValidationErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

// class NameFieldErrorState extends DHState {
//   final String errorText;

//   NameFieldErrorState(this.errorText);

//   @override
//   List<Object> get props => [errorText];
// }

// class EmailFieldErrorState extends DHState {
//   final String errorText;

//   EmailFieldErrorState(this.errorText);

//   @override
//   List<Object> get props => [errorText];
// }

// class PhoneFieldErrorState extends DHState {
//   final String errorText;

//   PhoneFieldErrorState(this.errorText);

//   @override
//   List<Object> get props => [errorText];
// }

// class PasswordFieldErrorState extends DHState {
//   final String errorText;

//   PasswordFieldErrorState(this.errorText);

//   @override
//   List<Object> get props => [errorText];
// }
