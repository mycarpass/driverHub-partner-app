import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/presenter/services_state.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ServicePricesBottomSheet extends StatelessWidget {
  const ServicePricesBottomSheet._({this.serviceDto});

  factory ServicePricesBottomSheet.create() {
    return const ServicePricesBottomSheet._();
  }

  factory ServicePricesBottomSheet.update(PartnerServiceDto _serviceDto) {
    return ServicePricesBottomSheet._(
      serviceDto: _serviceDto,
    );
  }

  final PartnerServiceDto? serviceDto;

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<ServicesRegisterPresenter>();

    if (serviceDto != null) {
      presenter.serviceEntity.id = serviceDto!.serviceId;
      presenter.priceHatchController.text = serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.hatchback)
              .isEmpty
          ? "R\$ 0,00"
          : serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.hatchback)
              .first
              .price
              .priceInReal;
      presenter.priceSedanController.text = serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.sedan)
              .isEmpty
          ? "R\$ 0,00"
          : serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.sedan)
              .first
              .price
              .priceInReal;
      presenter.priceSuvController.text = serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.suv)
              .isEmpty
          ? "R\$ 0,00"
          : serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.suv)
              .first
              .price
              .priceInReal;
      presenter.pricePickupController.text = serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.pickup)
              .isEmpty
          ? "R\$ 0,00"
          : serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.pickup)
              .first
              .price
              .priceInReal;

      presenter.priceRAMController.text = serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.ram)
              .isEmpty
          ? "R\$ 0,00"
          : serviceDto!.prices
              .where((element) => element.carBodyType == CarBodyType.ram)
              .first
              .price
              .priceInReal;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(serviceDto != null
                          ? "Editar preços"
                          : "Cadastrar preços")
                      .label1_bold()),
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
                      presenter.moneyBaseController.text;
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            CarBodyType.hatchback.icon,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColor.blackColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text('Hatch').body_bold(),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          width: MediaQuery.sizeOf(context).width / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: AppColor.textSecondaryColor)),
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            CarBodyType.sedan.icon,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColor.blackColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text('Sedan').body_bold(),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          width: MediaQuery.sizeOf(context).width / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: AppColor.textSecondaryColor)),
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            CarBodyType.suv.icon,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColor.blackColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text('SUV').body_bold(),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          width: MediaQuery.sizeOf(context).width / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: AppColor.textSecondaryColor)),
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            CarBodyType.pickup.icon,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColor.blackColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text('Caminhonete').body_bold(),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          width: MediaQuery.sizeOf(context).width / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: AppColor.textSecondaryColor)),
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            CarBodyType.ram.icon,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                                AppColor.blackColor, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text('RAM').body_bold(),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          width: MediaQuery.sizeOf(context).width / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                  color: AppColor.textSecondaryColor)),
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
                                      itemCount:
                                          presenter.addtionalWashes.length,
                                      itemBuilder: (context, index) {
                                        MoneyMaskedTextController
                                            moneyFormatter =
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 12),
                                                width: MediaQuery.sizeOf(context)
                                                        .width /
                                                    3,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
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
                                                      fontFamily:
                                                          'CircularStd'),
                                                  smartDashesType:
                                                      SmartDashesType.disabled,
                                                  onChanged: (text) {
                                                    presenter
                                                        .setBasePriceAddtionalService(
                                                            index,
                                                            moneyFormatter
                                                                .text);
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
                if (state is ServiceRegisteredSuccessful) {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                  DHSnackBar().showSnackBar("Parabéns!",
                      "Serviço cadastrado com sucesso", DHSnackBarType.success);
                } else if (state is DHErrorState) {
                  DHSnackBar().showSnackBar(
                      "Ops...",
                      "Ocorreu um erro ao tentar salvar o serviço, tente novamente mais tarde",
                      DHSnackBarType.error);
                }
              }, builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is DHLoadingState
                        ? () {}
                        : () {
                            if (presenter.isValideToContinue()) {
                              serviceDto != null
                                  ? presenter.updateService()
                                  : presenter.saveService();
                            } else {
                              DHSnackBar().showSnackBar(
                                  "Ops...",
                                  "Preencha corretamente todos os dados para continuar",
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
                        : serviceDto != null
                            ? const Text("Salvar")
                            : const Text("Cadastrar"),
                  ),
                );
              }),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
