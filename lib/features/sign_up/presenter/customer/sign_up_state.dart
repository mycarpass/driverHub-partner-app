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

class EstablishmentFieldErrorState extends DHState {
  final String errorText;

  EstablishmentFieldErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class CNPJFieldErrorState extends DHState {
  final String errorText;

  CNPJFieldErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class PhoneFieldErrorState extends DHState {
  final String errorText;

  PhoneFieldErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class NameErrorState extends DHState {
  final String errorText;

  NameErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class CPFErrorState extends DHState {
  final String errorText;

  CPFErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class AddressNumberErrorState extends DHState {
  final String errorText;

  AddressNumberErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class CepErrorState extends DHState {
  final String errorText;

  CepErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class AddressErrorState extends DHState {
  final String errorText;

  AddressErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}


// class PasswordFieldErrorState extends DHState {
//   final String errorText;

//   PasswordFieldErrorState(this.errorText);

//   @override
//   List<Object> get props => [errorText];
// }
