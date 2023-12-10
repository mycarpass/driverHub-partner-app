import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_state.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/widgets/list_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'layout_input_base/layout_input_base.dart';

class AddressLayout extends LayoutInputBase {
  AddressLayout({super.key, this.text});

  final String? text;

  final MaskTextInputFormatter formatter =
      MaskTextInputFormatter(mask: "#####-###", filter: {"#": RegExp('[0-9]')});
  final TextEditingController complementController =
      TextEditingController(text: '');
  final TextEditingController addressController =
      TextEditingController(text: '');
  final TextEditingController numberController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<AddressPresenter>();
    var signUpPresenter = context.read<SignUpPresenter>();
    return BlocConsumer<SignUpPresenter, DHState>(
        listener: (context, state) {
          if (state is AddressErrorState) {
            DHSnackBar().showSnackBar(
                'Atenção',
                "Preencha o endereço ou encontre o seu estabelecimento no campo abaixo",
                DHSnackBarType.error);
          }
        },
        builder: (context, state) => ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Endereço",
                  textAlign: TextAlign.center,
                ).largeTitle_bold(),
                const SizedBox(
                  height: 32,
                ),
                // DHTextField(
                //   hint: "00000-000",
                //   title: "CEP",
                //   icon: Icons.location_pin,
                //   autofocus: true,
                //   onChanged: (_) {},
                //   // controller: TextEditingController(text: checkAddressParams.street),
                //   controller: TextEditingController(text: ''),
                //   readOnly: false,
                //   suffixIcon: Icons.search,
                //   formatters: [formatter],
                //   onClickSuffixIcon: () {},
                // ),
                BlocBuilder<AddressPresenter, DHState>(
                  builder: (context, state) {
                    return Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 120,
                            child: DHTextField(
                              //hint: "Ex: DH Estética Automotiva",
                              hint: 'Buscar endereço',
                              controller: addressController,
                              icon: Icons.search,
                              suffixIcon: Icons.clear,

                              onClickSuffixIcon: () {
                                addressController.clear();
                                context.read<AddressPresenter>().searchText =
                                    "";
                                presenter.addressSelected = null;
                                context.read<AddressPresenter>().clear();
                              },
                              onChanged: (query) async {
                                presenter.addressSelected = null;
                                context
                                    .read<AddressPresenter>()
                                    .isSearching(query);
                                context.read<AddressPresenter>().searchText =
                                    query;
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.read<AddressPresenter>().search(),
                            child: const Text("Buscar").label2_bold(
                              style: TextStyle(
                                color: state is AddressIsSearchingState &&
                                        state.isEnableToSearch
                                    ? AppColor.accentColor
                                    : AppColor.accentHoverColor
                                        .withOpacity(0.2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      presenter.addressList.isNotEmpty &&
                              presenter.addressSelected == null
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: presenter.addressList.length,
                              itemBuilder: (context, index) {
                                final presenter =
                                    context.read<AddressPresenter>();
                                List<GeoLocationResponseDto> listAddress =
                                    presenter.addressList;
                                return BlocBuilder<AddressPresenter, DHState>(
                                    builder: (context, state) {
                                  return GestureDetector(
                                    onTap: state is DHLoadingState
                                        ? () {}
                                        : () async {
                                            GeoLocationResponseDto addressDto =
                                                listAddress[index];
                                            presenter.selectAddress(addressDto);
                                            if (presenter.addressSelected !=
                                                null) {
                                              await presenter.fetchLatLong(
                                                  presenter.addressSelected!);

                                              signUpPresenter
                                                      .prospectEntity.address =
                                                  presenter.addressSelected;
                                              addressController.text = '';

                                              presenter.clear();
                                            }
                                          },
                                    child: AddressListItemCell(
                                        title: listAddress[index].title,
                                        description:
                                            listAddress[index].description),
                                  );
                                });
                              })
                          : presenter.addressSelected != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AddressListItemCell(
                                        showChevron: false,
                                        icon: Icons.check,
                                        title:
                                            presenter.addressSelected?.title ??
                                                "",
                                        description: presenter
                                                .addressSelected?.description ??
                                            ""),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text('O atendimento acontece no')
                                        .body_bold(),
                                    CustomRadioButton(
                                      elevation: 0,
                                      absoluteZeroSpacing: true,
                                      unSelectedColor: AppColor.backgroundColor,
                                      buttonLables: const [
                                        'Estabelecimento',
                                        'A domicílio',
                                        'Em ambos',
                                      ],
                                      buttonValues: const [
                                        "ON_SITE",
                                        "DELIVERY",
                                        "BOTH",
                                      ],
                                      buttonTextStyle: const ButtonTextStyle(
                                          selectedColor:
                                              AppColor.backgroundColor,
                                          unSelectedColor:
                                              AppColor.textSecondaryColor,
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'CircularStd')),
                                      radioButtonValue: (value) {
                                        signUpPresenter
                                            .prospectEntity.serviceType = value;
                                      },
                                      defaultSelected: "ON_SITE",
                                      height: 60,
                                      unSelectedBorderColor:
                                          AppColor.borderColor,
                                      margin: const EdgeInsets.all(8),
                                      enableShape: true,
                                      shapeRadius: 16,
                                      autoWidth: true,
                                      radius: 16,
                                      selectedColor: AppColor.accentColor,
                                    ),
                                    BlocBuilder<SignUpPresenter, DHState>(
                                        builder: (context, state) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                DHTextField(
                                                  hint: "00000-000",
                                                  title: "CEP",
                                                  formatters: [formatter],
                                                  icon: Icons
                                                      .location_city_outlined,
                                                  textError:
                                                      state is CepErrorState
                                                          ? state.errorText
                                                          : "",
                                                  textErrorVisible:
                                                      state is CepErrorState,
                                                  onChanged: (cepNumber) {
                                                    signUpPresenter
                                                        .prospectEntity
                                                        .address
                                                        ?.cep = cepNumber;
                                                  },
                                                  controller:
                                                      TextEditingController(
                                                          text: signUpPresenter
                                                              .prospectEntity
                                                              .address
                                                              ?.cep),
                                                ),
                                                DHTextField(
                                                  hint: "Informe o número",
                                                  title: "Número",
                                                  icon:
                                                      Icons.onetwothree_rounded,
                                                  textError: state
                                                          is AddressNumberErrorState
                                                      ? state.errorText
                                                      : "",
                                                  textErrorVisible: state
                                                      is AddressNumberErrorState,
                                                  onChanged: (addressNumber) {
                                                    signUpPresenter
                                                            .prospectEntity
                                                            .address
                                                            ?.number =
                                                        addressNumber;
                                                  },
                                                  controller:
                                                      TextEditingController(
                                                          text: signUpPresenter
                                                              .prospectEntity
                                                              .address
                                                              ?.number),
                                                ),
                                              ],
                                            )),
                                  ],
                                )
                              : const SizedBox.shrink(),
                    ]);
                  },
                ),
              ],
            ));
  }

  @override
  SignUpStep get step => SignUpStep.address;

  @override
  void action(BuildContext context) {
    context.read<SignUpPresenter>().goNextStep();
  }
}
