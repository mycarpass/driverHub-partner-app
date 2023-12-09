import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ServicePricesBottomSheet extends StatelessWidget {
  const ServicePricesBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<ServicesRegisterPresenter>();
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: const Text("Cadastrar preços").label1_bold()),
            const SizedBox(
              height: 24,
            ),
            const Text('Serviço').caption1_emphasized(
                style: const TextStyle(color: AppColor.textSecondaryColor)),
            const SizedBox(
              height: 4,
            ),
            Text(presenter.serviceEntity.name).body_regular(
                style: const TextStyle(color: AppColor.textPrimaryColor)),
            const SizedBox(
              height: 12,
            ),
            DHTextField(
              hint: "Ex: R\$ 0,00",
              isOptional: !presenter.serviceEntity.isLiveOnApp,
              title: "Preço Base",
              keyboardType: TextInputType.number,
              controller: presenter.moneyBaseController,
              icon: Icons.monetization_on_outlined,
              onChanged: (moneyBase) {
                presenter.moneyBaseController.text = moneyBase;
                presenter.priceHatchController.text = moneyBase;
                presenter.priceSedanController.text = moneyBase;
                presenter.priceSuvController.text = moneyBase;
                presenter.pricePickupController.text = moneyBase;
                presenter.priceRAMController.text = moneyBase;
                presenter.serviceEntity.basePrice =
                    presenter.moneyBaseController.numberValue;
              },
              //  controller: nameController,
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(children: [
                  const Text('Preço por carroceria').label2_bold()
                ]),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hatch').body_bold(),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border:
                                Border.all(color: AppColor.textSecondaryColor)),
                        child: TextField(
                          cursorColor: AppColor.whiteColor,
                          enabled: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColor.textPrimaryColor,
                              fontFamily: 'CircularStd'),
                          smartDashesType: SmartDashesType.disabled,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'R\$ 0,00',
                              hintStyle: TextStyle(
                                  color: AppColor.textTertiaryColor,
                                  fontFamily: 'CircularStd')),
                          keyboardType: TextInputType.number,
                          controller: presenter.priceHatchController,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sedan').body_bold(),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border:
                                Border.all(color: AppColor.textSecondaryColor)),
                        child: TextField(
                          cursorColor: AppColor.whiteColor,
                          controller: presenter.priceSedanController,
                          enabled: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColor.textPrimaryColor,
                              fontFamily: 'CircularStd'),
                          smartDashesType: SmartDashesType.disabled,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'R\$ 0,00',
                              hintStyle: TextStyle(
                                  color: AppColor.textTertiaryColor,
                                  fontFamily: 'CircularStd')),
                          keyboardType: TextInputType.number,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('SUV').body_bold(),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border:
                                Border.all(color: AppColor.textSecondaryColor)),
                        child: TextField(
                            cursorColor: AppColor.whiteColor,
                            enabled: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.textPrimaryColor,
                                fontFamily: 'CircularStd'),
                            smartDashesType: SmartDashesType.disabled,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'R\$ 0,00',
                                hintStyle: TextStyle(
                                    color: AppColor.textTertiaryColor,
                                    fontFamily: 'CircularStd')),
                            keyboardType: TextInputType.number,
                            controller: presenter.priceSuvController))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Caminhonete').body_bold(),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border:
                                Border.all(color: AppColor.textSecondaryColor)),
                        child: TextField(
                            cursorColor: AppColor.whiteColor,
                            enabled: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.textPrimaryColor,
                                fontFamily: 'CircularStd'),
                            smartDashesType: SmartDashesType.disabled,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'R\$ 0,00',
                                hintStyle: TextStyle(
                                    color: AppColor.textTertiaryColor,
                                    fontFamily: 'CircularStd')),
                            keyboardType: TextInputType.number,
                            controller: presenter.pricePickupController))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('RAM').body_bold(),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border:
                                Border.all(color: AppColor.textSecondaryColor)),
                        child: TextField(
                            cursorColor: AppColor.whiteColor,
                            enabled: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.textPrimaryColor,
                                fontFamily: 'CircularStd'),
                            smartDashesType: SmartDashesType.disabled,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'R\$ 0,00',
                                hintStyle: TextStyle(
                                    color: AppColor.textTertiaryColor,
                                    fontFamily: 'CircularStd')),
                            keyboardType: TextInputType.number,
                            controller: presenter.priceRAMController))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            presenter.serviceEntity.isLiveOnApp &&
                    presenter.serviceEntity.category == ServiceCategory.wash
                ? Column(
                    children: [
                      const Divider(),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: [
                          Row(children: [
                            const Text('Adicionais na Lavada ').label2_bold(),
                            const Text('(Opcional)').label2_regular(),
                          ]),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<ServicesRegisterPresenter, DHState>(
                              builder: (context, state) => ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: presenter.addtionalWashes.length,
                                    itemBuilder: (context, index) {
                                      MoneyMaskedTextController moneyFormatter =
                                          MoneyMaskedTextController(
                                              decimalSeparator: ",",
                                              leftSymbol: "R\$",
                                              initialValue: 0.00);
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                hoverColor:
                                                    AppColor.accentHoverColor,
                                                side: const BorderSide(
                                                    color:
                                                        AppColor.accentColor),
                                                checkColor:
                                                    AppColor.backgroundColor,
                                                activeColor:
                                                    AppColor.accentColor,
                                                value: presenter
                                                    .addtionalWashes[index]
                                                    .isSelected,
                                                onChanged: (value) {
                                                  presenter
                                                      .selectAddtionalService(
                                                          index,
                                                          value ?? false);
                                                },
                                              ),
                                              Text(presenter
                                                      .addtionalWashes[index]
                                                      .name)
                                                  .body_regular(
                                                      style: TextStyle(
                                                          color: presenter
                                                                      .addtionalWashes[
                                                                          index]
                                                                      .isSelected ??
                                                                  false
                                                              ? AppColor
                                                                  .textPrimaryColor
                                                              : AppColor
                                                                  .textSecondaryColor)),
                                            ],
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 12),
                                              width:
                                                  MediaQuery.sizeOf(context).width /
                                                      3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                      color: presenter
                                                                  .addtionalWashes[
                                                                      index]
                                                                  .isSelected ??
                                                              false
                                                          ? AppColor
                                                              .textSecondaryColor
                                                          : AppColor.textTertiaryColor)),
                                              child: TextField(
                                                cursorColor:
                                                    AppColor.whiteColor,
                                                enabled: presenter
                                                    .addtionalWashes[index]
                                                    .isSelected,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: presenter
                                                                .addtionalWashes[
                                                                    index]
                                                                .isSelected ??
                                                            false
                                                        ? AppColor
                                                            .textPrimaryColor
                                                        : AppColor
                                                            .textTertiaryColor,
                                                    fontFamily: 'CircularStd'),
                                                smartDashesType:
                                                    SmartDashesType.disabled,
                                                onChanged: (text) {
                                                  presenter
                                                      .setBasePriceAddtionalService(
                                                          index,
                                                          moneyFormatter
                                                              .numberValue);
                                                },
                                                decoration: const InputDecoration
                                                    .collapsed(
                                                    hintText: 'R\$ 0,00',
                                                    hintStyle: TextStyle(
                                                        color: AppColor
                                                            .textTertiaryColor,
                                                        fontFamily:
                                                            'CircularStd')),
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: moneyFormatter,
                                              ))
                                        ],
                                      );
                                    },
                                  )),
                        ],
                      )
                    ],
                  )
                : const SizedBox(height: 24),
            BlocConsumer<ServicesRegisterPresenter, DHState>(
                listener: (context, state) {
              if (state is DHSuccessState) {
                Navigator.of(context).pop(true);
                DHSnackBar().showSnackBar("Oba!",
                    "Serviço cadastrado com sucesso", DHSnackBarType.success);
              }
            }, builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is DHLoadingState
                      ? () {}
                      : () => DHSnackBar().showSnackBar("Ops...",
                          "Preencha o nome e o telefone", DHSnackBarType.error),
                  child: state is DHLoadingState
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColor.backgroundColor,
                          ),
                        )
                      : const Text("Continuar"),
                ),
              );
            }),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }
}
