import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/bottomsheets/cutomer_register_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/input/uppercase_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class CustomerRegisterBottomSheet extends StatelessWidget {
  CustomerRegisterBottomSheet({
    super.key,
  });

  final MaskTextInputFormatter formatter = MaskTextInputFormatter(
    mask: "#######",
    initialText: "ABC1234",
    filter: {
      "#": RegExp(
        r'^[a-zA-Z0-9]+$',
      ),
    },
  );

  final MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: "(##) #####-####",
    initialText: "(00) 00000-0000",
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController plateControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerRegisterPresenter(),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text("Cadastrar cliente").label1_bold(),
              const SizedBox(
                height: 16,
              ),
              DHTextField(
                hint: "Joao da silva",
                title: "Nome",
                icon: Icons.person_outline,
                onChanged: (_) {},
                controller: nameController,
              ),
              const SizedBox(
                height: 8,
              ),
              DHTextField(
                title: "Telefone",
                hint: "(99) 999999-9999",
                icon: Icons.phone_outlined,
                formatters: [phoneFormatter],
                onChanged: (_) {},
                controller: phoneController,
              ),
              const SizedBox(
                height: 8,
              ),
              DHTextField(
                title: "Placa (Opcional)",
                hint: "XXX0000",
                icon: Icons.fingerprint_outlined,
                formatters: [UpperCaseTextFormatter(), formatter],
                onChanged: (_) {},
                controller: plateControler,
              ),
              const SizedBox(
                height: 32,
              ),
              BlocConsumer<CustomerRegisterPresenter, DHState>(
                  listener: (context, state) {
                if (state is DHSuccessState) {
                  Navigator.of(context).pop(true);
                  DHSnackBar().showSnackBar("Oba!",
                      "Cliente cadastrado com sucesso", DHSnackBarType.success);
                }
              }, builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is DHLoadingState
                        ? () {}
                        : () => nameController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty
                            ? context
                                .read<CustomerRegisterPresenter>()
                                .register(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  plate: plateControler.text,
                                )
                            : DHSnackBar().showSnackBar(
                                "Ops...",
                                "Preencha pelo nemos o nome e o telefone",
                                DHSnackBarType.error),
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
