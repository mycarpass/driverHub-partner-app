import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_state.dart';
import 'package:driver_hub_partner/features/sign_up/router/params/check_address_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCheckView extends StatelessWidget {
  AddressCheckView({
    super.key,
  });

  final TextEditingController complementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CheckAddressParams checkAddressParams =
        ModalRoute.of(context)!.settings.arguments as CheckAddressParams;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: checkAddressParams.signUpPresenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocListener<AddressPresenter, DHState>(
              listener: (context, state) {
                if (state is AddressAddedSuccessfulState) {
                  Navigator.pop(context);
                }
              },
              child: ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: () {
                      checkAddressParams.signUpPresenter.isWithoutComplement =
                          false;
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Voltar"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Valide o endereço").largeTitle_bold(),
                  const SizedBox(
                    height: 32,
                  ),
                  DHTextField(
                    hint: "",
                    title: "Rua",
                    icon: Icons.streetview,
                    onChanged: (_) {},
                    controller:
                        TextEditingController(text: checkAddressParams.street),
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DHTextField(
                          hint: "",
                          title: "Número",
                          icon: Icons.onetwothree_rounded,
                          onChanged: (_) {},
                          controller: TextEditingController(
                              text: checkAddressParams.number),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DHTextField(
                        hint: "EX: Apto 42, Bloco A",
                        title: "Complemento",
                        icon: Icons.abc,
                        autofocus: true,
                        onChanged: (_) {},
                        controller: complementController,
                      ),
                      BlocBuilder<AddressPresenter, DHState>(
                          builder: (context, state) {
                        return Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              value: checkAddressParams
                                  .signUpPresenter.isWithoutComplement,
                              onChanged: (_) {
                                checkAddressParams.signUpPresenter
                                    .changeIsWithoutComplement();
                              },
                              checkColor: AppColor.accentColor,
                              overlayColor: MaterialStateProperty.all(
                                AppColor.backgroundTertiary,
                              ),
                              side: const BorderSide(
                                color: AppColor.secondaryColor,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              fillColor: MaterialStateProperty.all(
                                AppColor.backgroundTertiary,
                              ),
                              hoverColor: AppColor.blackColor,
                              activeColor: AppColor.accentColor,
                              focusColor: AppColor.blackColor,
                            ),
                            const Text("Sem complemento").body_regular()
                          ],
                        );
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DHTextField(
                          hint: "",
                          title: "Estado",
                          icon: Icons.map,
                          onChanged: (_) {},
                          controller: TextEditingController(
                              text: checkAddressParams.state),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: DHTextField(
                          hint: "",
                          title: "Cidade",
                          icon: Icons.abc,
                          onChanged: (_) {},
                          controller: TextEditingController(
                              text: checkAddressParams.city),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  BlocBuilder<AddressPresenter, DHState>(
                    builder: (context, state) => ElevatedButton(
                      onPressed: () async {
                        !checkAddressParams
                                    .signUpPresenter.isWithoutComplement &&
                                complementController.text.isEmpty
                            ? DHSnackBar().showSnackBar(
                                "Atenção",
                                "Caso não tenha complemento, marque a opção abaixo do campo",
                                DHSnackBarType.warning)
                            : await checkAddressParams.signUpPresenter
                                .insertAddress(
                                    checkAddressParams.geoLocationResponseDto,
                                    complementController.text);
                      },
                      child: state is DHLoadingState
                          ? const DHCircularLoading()
                          : const Text("Adicionar endereço"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
