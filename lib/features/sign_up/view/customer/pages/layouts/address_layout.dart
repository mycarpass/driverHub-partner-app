import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_state.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/widgets/list_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'layout_input_base/layout_input_base.dart';

class AddressLayout extends LayoutInputBase {
  AddressLayout({super.key, this.text});

  final String? text;

  final MaskTextInputFormatter formatter = MaskTextInputFormatter(
      mask: "#####-###",
      initialText: "00000-000",
      filter: {"#": RegExp('[0-9]')});
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
    return ListView(
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
                        context.read<AddressPresenter>().searchText = "";
                        presenter.addressSelected = null;
                        context.read<AddressPresenter>().clear();
                      },
                      onChanged: (query) async {
                        presenter.addressSelected = null;
                        context.read<AddressPresenter>().isSearching(query);
                        context.read<AddressPresenter>().searchText = query;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.read<AddressPresenter>().search(),
                    child: const Text("Buscar").label2_bold(
                      style: TextStyle(
                        color: state is AddressIsSearchingState &&
                                state.isEnableToSearch
                            ? AppColor.accentColor
                            : AppColor.accentHoverColor.withOpacity(0.2),
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
                        final presenter = context.read<AddressPresenter>();
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
                                    if (presenter.addressSelected != null) {
                                      await presenter.fetchLatLong(
                                          presenter.addressSelected!);

                                      signUpPresenter.prospectEntity.address =
                                          presenter.addressSelected;
                                      addressController.text = '';
                                      presenter.clear();

                                      //FocusScope.of(context).unfocus();
                                    }

                                    //addressController.dispose();
                                    // if (presenter.isFilledHouseNumber(
                                    //     addressDto.title)) {
                                    //   presenter.verifyAddress(
                                    //     addressDto,
                                    //   );

                                    //   // next step
                                    // } else {
                                    //   // modal pra por numero
                                    //   dynamic addressNumber =
                                    //       await showModalBottomSheet<String>(
                                    //           context: context,
                                    //           isScrollControlled: true,
                                    //           builder: (BuildContext context) {
                                    //             return const AddressNumberWidget();
                                    //           });

                                    //   String addressFull =
                                    //       presenter.concatenateAddressNumber(
                                    //           addressDto.title, addressNumber);

                                    //   if (addressNumber == "S/N") {
                                    //     addressDto.title = addressFull;
                                    //     await presenter
                                    //         .verifyAddress(addressDto);
                                    //   } else {
                                    //     presenter.searchText = addressFull;
                                    //     addressController.text = addressFull;

                                    //     presenter.search();
                                    //   }
                                    // }
                                  },
                            child: AddressListItemCell(
                                title: listAddress[index].title,
                                description: listAddress[index].description),
                          );
                        });
                      })
                  : presenter.addressSelected != null
                      ? Column(
                          children: [
                            AddressListItemCell(
                                showChevron: false,
                                icon: Icons.check,
                                title: presenter.addressSelected?.title ?? "",
                                description:
                                    presenter.addressSelected?.description ??
                                        ""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: DHTextField(
                                    hint: "Informe o número",
                                    title: "Número",
                                    icon: Icons.onetwothree_rounded,
                                    onChanged: (_) {},
                                    controller: TextEditingController(text: ''),
                                    readOnly: false,
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     DHTextField(
                            //       hint: "EX: Apto 42, Bloco A",
                            //       title: "Complemento",
                            //       icon: Icons.abc,
                            //       // autofocus: true,
                            //       onChanged: (_) {},
                            //       controller: complementController,
                            //     ),
                            //     Row(
                            //       children: [
                            //         Checkbox(
                            //           materialTapTargetSize:
                            //               MaterialTapTargetSize.padded,
                            //           // value:
                            //           //     checkAddressParams.signUpPresenter.isWithoutComplement,
                            //           value: false,
                            //           onChanged: (_) {
                            //             // checkAddressParams.signUpPresenter
                            //             //     .changeIsWithoutComplement();
                            //           },
                            //           checkColor: AppColor.accentColor,
                            //           overlayColor: MaterialStateProperty.all(
                            //             AppColor.backgroundTertiary,
                            //           ),
                            //           side: const BorderSide(
                            //             color: AppColor.secondaryColor,
                            //           ),
                            //           shape: const RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //               Radius.circular(12),
                            //             ),
                            //           ),
                            //           fillColor: MaterialStateProperty.all(
                            //             AppColor.backgroundTertiary,
                            //           ),
                            //           hoverColor: AppColor.blackColor,
                            //           activeColor: AppColor.accentColor,
                            //           focusColor: AppColor.blackColor,
                            //         ),
                            //         const Text("Sem complemento").body_regular()
                            //       ],
                            //     )
                            //   ],
                            // )
                          ],
                        )
                      : const SizedBox.shrink(),
            ]);
          },
        ),
      ],
    );
  }

  @override
  SignUpStep get step => SignUpStep.phone;

  @override
  void action(BuildContext context) {
    context.read<SignUpPresenter>().goNextStep();
  }
}
