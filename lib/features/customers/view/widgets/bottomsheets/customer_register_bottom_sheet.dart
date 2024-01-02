import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/presenter/cutomer_register_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/input/uppercase_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class CustomerRegisterBottomSheet extends StatefulWidget {
  CustomerRegisterBottomSheet._(
      {required this.isCreatingCustomer, this.customerDto});
  bool isCreatingCustomer = false;
  CustomerDto? customerDto;

  factory CustomerRegisterBottomSheet.create() {
    return CustomerRegisterBottomSheet._(
      isCreatingCustomer: true,
      customerDto: null,
    );
  }

  factory CustomerRegisterBottomSheet.update(CustomerDto customerDto) {
    return CustomerRegisterBottomSheet._(
      isCreatingCustomer: false,
      customerDto: customerDto,
    );
  }

  @override
  State<CustomerRegisterBottomSheet> createState() =>
      _CustomerRegisterBottomSheetState();
}

class _CustomerRegisterBottomSheetState
    extends State<CustomerRegisterBottomSheet> {
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

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController plateControler;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    plateControler = TextEditingController();
    _checkBottomSheetType();
  }

  void _checkBottomSheetType() {
    if (widget.isCreatingCustomer) {
      DoNothingAction();
    }
    if (!widget.isCreatingCustomer) {
      nameController.text = widget.customerDto?.name.name ?? "";
      phoneController.text = widget.customerDto?.phone.value ?? "";
      plateControler.text = widget.customerDto?.vehicle?.plate ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocProvider(
        create: (context) => CustomerRegisterPresenter(),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(widget.isCreatingCustomer
                        ? "Cadastrar cliente"
                        : "Editar cliete")
                    .label1_bold(),
                const SizedBox(
                  height: 16,
                ),
                DHTextField(
                  hint: "Joao da silva",
                  title: "Nome",
                  icon: Icons.person_outline,
                  onChanged: (_) {
                    nameController.text = _;
                  },
                  controller: nameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                DHTextField(
                  title: "Whatsapp",
                  hint: "(99) 999999-9999",
                  icon: Icons.phone_outlined,
                  formatters: [phoneFormatter],
                  onChanged: (_) {
                    phoneController.text = _;
                  },
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 8,
                ),
                DHTextField(
                  title: "Placa (Opcional)",
                  hint: "XXX0000",
                  icon: Icons.car_rental_outlined,
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
                    // Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);
                    DHSnackBar().showSnackBar(
                        "Oba!",
                        widget.isCreatingCustomer
                            ? "Cliente cadastrado com sucesso!"
                            : "Cliente editado com sucesso!",
                        DHSnackBarType.success);
                  }

                  if (state is DHErrorState) {
                    Navigator.of(context).pop(true);
                    DHSnackBar().showSnackBar(
                        "Opss...",
                        "Não foi possível atualizar os dados desse cliente",
                        DHSnackBarType.error);
                  }
                }, builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is DHLoadingState
                          ? () {}
                          : () => nameController.text.isNotEmpty &&
                                  phoneController.text.isNotEmpty
                              ? widget.isCreatingCustomer
                                  ? context
                                      .read<CustomerRegisterPresenter>()
                                      .register(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        plate: plateControler.text,
                                      )
                                  : context
                                      .read<CustomerRegisterPresenter>()
                                      .update(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          plate: plateControler.text,
                                          id: widget.customerDto!.customerId
                                              .toString())
                              : DHSnackBar().showSnackBar(
                                  "Ops...",
                                  "Preencha o nome e o telefone",
                                  DHSnackBarType.error),
                      child: state is DHLoadingState
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColor.backgroundColor,
                              ),
                            )
                          : Text(widget.isCreatingCustomer
                              ? "Cadastrar"
                              : "Atualizar"),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
