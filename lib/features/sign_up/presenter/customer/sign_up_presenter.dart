import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_notification/notification_package.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/home/router/home_router.dart';
import 'package:driver_hub_partner/features/sign_up/entities/customer/prospect_entity.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/create_customer_interactor.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/exceptions/email_already_registered.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPresenter extends Cubit<DHState> {
  SignUpPresenter() : super(SignUpInitialState());

  final CreateCustomerInteractor _createCustomerInteractor =
      DHInjector.instance.get<CreateCustomerInteractor>();

  final EmailValidationInteractor _emailValidationInteractor =
      DHInjector.instance.get<EmailValidationInteractor>();

  // static final facebookAppEvents = facebookAppEvents();

  var currentStep = 0;

  ///GETTERS AND SETTERS
  var _establishment = "";

  String get establishment => _establishment;

  set establishment(String newName) {
    _establishment = newName;
    prospectEntity.establishment = _establishment;
  }

  var _addressNumber = "";

  String get addressNumber => _addressNumber;

  set addressNumber(String newNumber) {
    _addressNumber = newNumber;
    prospectEntity.establishment = _addressNumber;
  }

  var _email = "";

  String get email => _email;

  set email(String newemail) {
    _email = newemail;
    prospectEntity.email = _email;
  }

  var _phone = "";

  String get phone => _phone;

  set phone(String newphone) {
    _phone = newphone;
    prospectEntity.phone = _phone;
  }

  var _password = "";

  String get password => _password;

  set password(String newpassword) {
    _password = newpassword;
    prospectEntity.password = _password;
  }

  var _personName = "";

  String get personName => _personName;

  set personName(String newPersonName) {
    _personName = newPersonName;
    prospectEntity.personName = newPersonName;
  }

  var _cpf = "";

  String get cpf => _cpf;

  set cpf(String newCpf) {
    _cpf = newCpf;
    prospectEntity.cpf = _cpf;
  }

  var _cnpj = "";

  String get cnpj => _cnpj;

  set cnpj(String newCnpj) {
    _cnpj = newCnpj;
    prospectEntity.cnpj = _cnpj;
  }

  var confirmEmailCode = "";

//////////////
  ///
  ///

  Future<void> sendEmail() async {
    try {
      emit(DHLoadingState());
      await _emailValidationInteractor.sendEmail(prospectEntity.email);
      emit(DHSuccessState());
      goNextStep();
    } catch (e) {
      emit(DHErrorState(
          error: "Não foi possível enviar o código para esse email"));
    }
  }

  Future<void> resendEmail() async {
    try {
      emit(DHLoadingState());
      await _emailValidationInteractor.sendEmail(prospectEntity.email);
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState(
          error: "Não foi possível reenviar o código para esse email"));
    }
  }

  Future<void> validateCode() async {
    try {
      emit(DHLoadingState());
      await _emailValidationInteractor.validateEmail(prospectEntity.email,
          confirmEmailCode, ValidationCodeRequestType.signup);
      emit(DHSuccessState());
      goNextStep();
      confirmEmailCode = "";
    } on InvalidCodeException catch (_) {
      emit(DHErrorState(error: "Código inválido, tente novamente"));
    } catch (_) {
      emit(DHErrorState(
          error: "Não foi possível validar o código, tente novamente"));
    }
  }

  var prospectEntity = ProspectEntity("", "", "", "", "", "", "ON_SITE");

  void createAccount() async {
    try {
      emit(DHLoadingState());
      await _createCustomerInteractor.createCustomer(prospectEntity);
      //  facebookAppEvents.setAdvertiserTracking(enabled: true);
      // facebookAppEvents.logEvent(name: 'user_registered', parameters: {
      //   'email': prospectEntity.email,
      // });
      // facebookAppEvents.setUserData(
      //     email: prospectEntity.email,
      //     firstName: prospectEntity.name,
      //     dateOfBirth: prospectEntity.birthDate,
      //     gender: prospectEntity.gender,
      //     phone: prospectEntity.phone);
      // facebookAppEvents.logCompletedRegistration(registrationMethod: "app");
      emit(SignUpFinishedState());
    } on EmailAlreadyRegistered {
      emit(DHErrorState(error: "Este e-mail ja está registrado"));
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void goNextStep() {
    if (currentStep == 5) {
      createAccount();
    } else {
      emit(SignUpNextStep(currentStep++));
    }
  }

  bool validate(SignUpStep step) {
    if (step == SignUpStep.emailCode) {
      if (!_validateEmailCodeLength()) {
        return false;
      } else {
        emit(DHSuccessState());
        return true;
      }
    }

    if (step == SignUpStep.partnerData) {
      String? errorEstablishment =
          prospectEntity.validatePropertyByField(SignUpFields.establishment);
      String? errorCNPJ =
          prospectEntity.validatePropertyByField(SignUpFields.cnpj);
      String? errorPhone =
          prospectEntity.validatePropertyByField(SignUpFields.phone);
      if (errorEstablishment != null) {
        emit(EstablishmentFieldErrorState(errorEstablishment));
      } else if (errorCNPJ != null) {
        emit(CNPJFieldErrorState(errorCNPJ));
      } else if (errorPhone != null) {
        emit(PhoneFieldErrorState(errorPhone));
      } else {
        emit(DHSuccessState());
        return true;
      }
    }

    if (step == SignUpStep.personData) {
      String? errorPersonName =
          prospectEntity.validatePropertyByField(SignUpFields.name);
      String? errorCPF =
          prospectEntity.validatePropertyByField(SignUpFields.cpf);

      if (errorPersonName != null) {
        emit(NameErrorState(errorPersonName));
      } else if (errorCPF != null) {
        emit(CPFErrorState(errorCPF));
      } else {
        emit(DHSuccessState());
        return true;
      }
    }

    if (step == SignUpStep.address) {
      if (prospectEntity.address == null) {
        emit(AddressErrorState("Informe um endereço para continuar"));
      }

      String? errorAddressNumber =
          prospectEntity.validatePropertyByField(SignUpFields.addressNumber);

      String? errorCep =
          prospectEntity.validatePropertyByField(SignUpFields.cep);

      if (errorAddressNumber != null) {
        emit(AddressNumberErrorState(errorAddressNumber));
      } else if (errorCep != null) {
        emit(CepErrorState(errorCep));
      } else {
        emit(DHSuccessState());
        return true;
      }
    }

    if (step == SignUpStep.email) {
      String? errorEmail =
          prospectEntity.validatePropertyByField(SignUpFields.email);
      if (errorEmail != null) {
        emit(EmailErrorText(errorEmail));
      } else {
        emit(DHSuccessState());
        return true;
      }
    }

    if (step == SignUpStep.password) {
      String? errorPassword =
          prospectEntity.validatePropertyByField(SignUpFields.password);
      if (errorPassword != null) {
        emit(PasswordFieldErrorState(errorPassword));
      } else {
        emit(DHSuccessState());
        return true;
      }
    }

    return false;
  }

  backStep() {
    if (currentStep == 0) {
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
    } else {
      emit(SignUpNextStep(currentStep--));
    }
  }

  goOnboarding() {
    Navigator.pushNamedAndRemoveUntil(
        NavigationService.navigatorKey.currentContext!,
        HomeRoutes.home,
        (route) => false);
  }

  bool _validateEmailCodeLength() {
    if (confirmEmailCode.length != 6) {
      DHSnackBar().showSnackBar("Ops...",
          "Preencha com todos os dígitos do código", DHSnackBarType.warning);
      return false;
    } else {
      return true;
    }
  }
}
