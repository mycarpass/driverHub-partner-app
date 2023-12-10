import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/home/presenter/entities/bank_entity.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class BankAccountRegisterBottomSheet extends StatelessWidget {
  BankAccountRegisterBottomSheet({
    this.accountCNPJ,
    super.key,
  });

  TextEditingController agencyController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  final String? accountCNPJ;

  final MaskTextInputFormatter formatterCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##",
      //initialText: "00.000.000/0000-00",
      filter: {"#": RegExp('[0-9]')});

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<OnboardingPresenter>();
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                  child: const Text("Cadastrar conta bancária").label1_bold()),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Registre uma conta bancária e receba diretamente nela suas vendas feitas pelo app da DriverHub",
                textAlign: TextAlign.center,
              ).body_regular(),
              const SizedBox(
                height: 16,
              ),
              CustomDropdown<BankEntity>.search(
                hintText: 'Selecione o banco',
                items: presenter.banksList,
                searchHintText: "Buscar",
                excludeSelected: true,
                closedFillColor: AppColor.backgroundColor,
                closedBorder: Border.all(color: AppColor.borderColor),
                expandedFillColor: AppColor.backgroundColor,
                closedSuffixIcon: const Icon(Icons.arrow_drop_down_outlined,
                    color: AppColor.iconPrimaryColor),
                expandedBorder: Border.all(color: AppColor.borderColor),
                noResultFoundText: "Nenhum banco encontrado",
                listItemBuilder: (context, item) =>
                    Text("${item.code} - ${item.name}").body_regular(),
                noResultFoundBuilder: (context, text) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(child: Text(text).body_regular())),

                headerBuilder: (context, selectedItem) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('BANCO').caption1_emphasized(
                          style: const TextStyle(
                              color: AppColor.textSecondaryColor)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("${selectedItem.code} - ${selectedItem.name}")
                          .body_regular(
                              style: const TextStyle(
                                  color: AppColor.textPrimaryColor))
                    ]),

                ///hideSelectedFieldWhenExpanded: true,
                // initialItem: presenter.banksList.values.toList()[0],
                onChanged: (value) {
                  presenter.selectBank(value);
                  print('changing value to: $value');
                },
              ),
              BlocBuilder<OnboardingPresenter, DHState>(
                  builder: (context, state) => Row(
                        children: [
                          SizedBox(
                              width:
                                  (MediaQuery.sizeOf(context).width / 2 - 48),
                              child: DHTextField(
                                hint: presenter.bankEntitySelected?.agencyMask
                                        .replaceAll('X', '0') ??
                                    "0000",
                                title: "Agência",
                                icon: Icons.onetwothree,
                                keyboardType: TextInputType.text,
                                onChanged: (_) {
                                  agencyController.text = _;
                                },
                                formatters: [
                                  MaskTextInputFormatter(
                                    mask: presenter
                                            .bankEntitySelected?.agencyMask ??
                                        "#####",
                                    filter: {
                                      "#": RegExp('[0-9]'),
                                    },
                                  )
                                ],
                                controller: agencyController,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                              width: (MediaQuery.sizeOf(context).width / 2),
                              child: DHTextField(
                                title: "Conta com dígito",
                                hint: "12345678-9",
                                icon: Icons.onetwothree,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true),
                                onChanged: (_) {
                                  accountController.text = _;
                                },
                                controller: accountController,
                              ))
                        ],
                      )),
              const SizedBox(height: 12),
              const Text('Tipo de conta').body_bold(),
              CustomRadioButton(
                elevation: 0,
                absoluteZeroSpacing: true,
                unSelectedColor: AppColor.backgroundColor,
                buttonLables: const [
                  'Corrente',
                  'Poupança',
                ],
                buttonValues: const [
                  "CC",
                  "CP",
                ],
                buttonTextStyle: const ButtonTextStyle(
                    selectedColor: AppColor.backgroundColor,
                    unSelectedColor: AppColor.textSecondaryColor,
                    textStyle:
                        TextStyle(fontSize: 16, fontFamily: 'CircularStd')),
                radioButtonValue: (value) {
                  presenter.bankAccountDto.typeAccount = value;
                  print(value);
                },
                defaultSelected: "CC",
                height: 60,
                unSelectedBorderColor: AppColor.borderColor,
                margin: const EdgeInsets.all(8),
                enableShape: true,
                shapeRadius: 16,
                autoWidth: true,
                radius: 16,
                selectedColor: AppColor.accentColor,
              ),
              const SizedBox(height: 12),
              const Text('Sua conta é...').body_bold(),
              CustomRadioButton(
                elevation: 0,
                absoluteZeroSpacing: true,
                unSelectedColor: AppColor.backgroundColor,
                buttonLables: const [
                  'Pessoa Física',
                  'Pessoa Jurídica',
                ],
                buttonValues: const [
                  "PF",
                  "PJ",
                ],
                buttonTextStyle: const ButtonTextStyle(
                    selectedColor: AppColor.backgroundColor,
                    unSelectedColor: AppColor.textSecondaryColor,
                    textStyle:
                        TextStyle(fontSize: 16, fontFamily: 'CircularStd')),
                radioButtonValue: (value) {
                  presenter.changeTypePerson(value);
                  print(value);
                },
                defaultSelected: "PF",
                height: 60,
                unSelectedBorderColor: AppColor.borderColor,
                margin: const EdgeInsets.all(8),
                enableShape: true,
                shapeRadius: 16,
                autoWidth: true,
                radius: 16,
                selectedColor: AppColor.accentColor,
              ),
              BlocBuilder<OnboardingPresenter, DHState>(
                  builder: (context, state) =>
                      presenter.bankAccountDto.typePerson == "PJ" &&
                              accountCNPJ == null
                          ? DHTextField(
                              //controller: cnpjController,
                              title: "CNPJ",
                              hint: "00.000.000/0001-00",
                              keyboardType: TextInputType.number,
                              icon: (Icons.numbers_rounded),
                              formatters: [formatterCNPJ],
                              onChanged: (cnpj) {
                                presenter.bankAccountDto.cnpj = cnpj;
                              },
                            )
                          : const SizedBox.shrink()),
              const SizedBox(
                height: 36,
              ),
              BlocConsumer<OnboardingPresenter, DHState>(
                  listener: (context, state) {
                if (state is DHSuccessState) {
                  Navigator.of(context).pop(true);
                  DHSnackBar().showSnackBar(
                      "Parabéns!",
                      "Conta bancária cadastrada com sucesso",
                      DHSnackBarType.success);
                } else if (state is DHErrorState) {
                  DHSnackBar().showSnackBar(
                      "Atenção!",
                      "Não foi possível cadastrar a conta bancária, verifique os dados e tente novamente.",
                      DHSnackBarType.error);
                }
              }, builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is DHLoadingState
                        ? () {}
                        : () {
                            if (agencyController.text.isNotEmpty &&
                                agencyController.text.length >= 3 &&
                                accountController.text.isNotEmpty &&
                                accountController.text.length >= 4 &&
                                presenter.bankEntitySelected != null) {
                              presenter.bankAccountDto.agency =
                                  agencyController.text;
                              presenter.bankAccountDto.account =
                                  accountController.text;

                              if (accountCNPJ == null &&
                                  presenter.bankAccountDto.typePerson == "PJ" &&
                                  (presenter.bankAccountDto.cnpj == null ||
                                      presenter.bankAccountDto.cnpj == "" ||
                                      !CNPJValidator.isValid(
                                          presenter.bankAccountDto.cnpj))) {
                                DHSnackBar().showSnackBar(
                                    "Ops...",
                                    "Preencha corretamente o CNPJ, para podermos cadastrar sua conta bancária!",
                                    DHSnackBarType.error);
                              } else {
                                // SUCESSO CHAMAR SERVIÇ
                                if (presenter.bankAccountDto.typePerson ==
                                    "PJ") {
                                  presenter.bankAccountDto.cnpj = accountCNPJ ??
                                      presenter.bankAccountDto.cnpj;
                                }

                                presenter.saveBankAccount();
                              }
                            } else {
                              DHSnackBar().showSnackBar(
                                  "Ops...",
                                  "Preencha todos os dados corretamente antes de cadastrar.",
                                  DHSnackBarType.error);
                            }
                          },
                    child: state is DHLoadingState
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColor.backgroundColor,
                            ),
                          )
                        : const Text("Cadastrar"),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
