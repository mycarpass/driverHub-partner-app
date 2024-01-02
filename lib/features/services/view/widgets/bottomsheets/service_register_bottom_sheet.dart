import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/presenter/services_state.dart';
import 'package:driver_hub_partner/features/services/view/widgets/bottomsheets/service_prices_register_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ServiceRegisterBottomSheet extends StatelessWidget {
  ServiceRegisterBottomSheet._(
      {super.key, required this.isCreatingService, this.partnerServiceDto});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController plateControler = TextEditingController();

  bool isCreatingService = false;
  PartnerServiceDto? partnerServiceDto;

  factory ServiceRegisterBottomSheet.create() {
    return ServiceRegisterBottomSheet._(
      isCreatingService: true,
    );
  }

  factory ServiceRegisterBottomSheet.update(
      PartnerServiceDto partnerServiceDto) {
    return ServiceRegisterBottomSheet._(
      isCreatingService: false,
      partnerServiceDto: partnerServiceDto,
    );
  }

  TextEditingController timeController = TextEditingController();
  String defaultServiceTypeSelected = "Lavada";

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<ServicesRegisterPresenter>();
    var descriptionController =
        TextEditingController(text: presenter.serviceEntity.description ?? "");
    if (partnerServiceDto != null) {
      presenter.serviceEntity.serviceTimeHours =
          partnerServiceDto!.hourTime.toString();
      presenter.setIsLiveOnApp(partnerServiceDto!.isLiveOnApp);
      descriptionController.text = partnerServiceDto!.description ?? "";
      presenter.serviceEntity.description =
          partnerServiceDto!.description ?? "";
      timeController.text = partnerServiceDto!.hourTime.toString();
      presenter.serviceEntity.name = partnerServiceDto!.name;

      presenter.setServiceCategory(partnerServiceDto!.type.name,
          shouldCleanData: false);
      partnerServiceDto!.type == ServiceType.service
          ? defaultServiceTypeSelected = "Serviço"
          : DoNothingAction();

      // presenter.selectServiceDropDown(partnerServiceDto.);
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(isCreatingService ? "Cadastrar serviço" : "Editar serviço")
                    .label1_bold(),
                const SizedBox(
                  height: 24,
                ),
                isCreatingService
                    ? const Text('O que gostaria de cadastrar?').body_bold()
                    : const SizedBox.shrink(),
                isCreatingService
                    ? CustomRadioButton(
                        elevation: 0,
                        absoluteZeroSpacing: true,
                        unSelectedColor: AppColor.backgroundColor,
                        buttonLables: const [
                          'Lavada',
                          'Serviço',
                        ],
                        buttonValues: const [
                          "Lavada",
                          "Serviço",
                        ],
                        buttonTextStyle: const ButtonTextStyle(
                            selectedColor: AppColor.backgroundColor,
                            unSelectedColor: AppColor.textSecondaryColor,
                            textStyle: TextStyle(
                                fontSize: 16, fontFamily: 'CircularStd')),
                        radioButtonValue: (value) {
                          presenter.setServiceCategory(value);
                        },
                        defaultSelected: defaultServiceTypeSelected,
                        height: 60,
                        unSelectedBorderColor: AppColor.borderColor,
                        selectedBorderColor: AppColor.borderColor,
                        margin: const EdgeInsets.all(8),
                        enableShape: true,
                        shapeRadius: 16,
                        autoWidth: true,
                        radius: 16,
                        selectedColor: AppColor.accentColor,
                      )
                    : const SizedBox.shrink(),
                Row(children: [
                  BlocBuilder<ServicesRegisterPresenter, DHState>(
                      builder: (context, state) => Checkbox(
                          hoverColor: AppColor.accentHoverColor,
                          value: presenter.serviceEntity.isLiveOnApp,
                          side: const BorderSide(color: AppColor.accentColor),
                          onChanged: (value) {
                            presenter.setIsLiveOnApp(value ?? false);
                          },
                          checkColor: AppColor.backgroundColor,
                          activeColor: AppColor.accentColor)),
                  const Text('Mostrar no App para Clientes da DriverHub?')
                      .caption1_bold(),
                ]),
                partnerServiceDto != null
                    ? DHTextField(
                        hint: partnerServiceDto!.name,
                        icon: Icons.garage_outlined,
                        onChanged: (_) {},
                        title: "Serviço",
                        disabled: true,
                      )
                    : BlocBuilder<ServicesRegisterPresenter, DHState>(
                        builder: (context, state) =>
                            CustomDropdown<ServiceEntity>.search(
                          hintText: state is LoadingServicesDropdownState
                              ? 'Aguarde carregando...'
                              : 'Selecione o serviço',
                          items: presenter.serviceEntity.category ==
                                  ServiceCategory.services
                              ? presenter.dropDownServices
                              : presenter.dropDownWashes,
                          searchHintText: "Buscar",
                          excludeSelected: true,
                          closedFillColor: AppColor.backgroundColor,
                          closedBorder: Border.all(color: AppColor.borderColor),
                          expandedFillColor: AppColor.backgroundColor,
                          closedSuffixIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: AppColor.iconPrimaryColor),
                          expandedBorder:
                              Border.all(color: AppColor.borderColor),
                          noResultFoundText:
                              "Nenhum serviço encontrado, entre em contato para adicionarmos o serviço desejado.",
                          listItemBuilder: (context, item) =>
                              Text(item.name).body_regular(),
                          noResultFoundBuilder: (context, text) => Padding(
                              padding: const EdgeInsets.all(16),
                              child: Center(child: Text(text).body_regular())),
                          headerBuilder: (context, selectedItem) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Serviço').caption1_emphasized(
                                    style: const TextStyle(
                                        color: AppColor.textSecondaryColor)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(selectedItem.name).body_regular(
                                    style: const TextStyle(
                                        color: AppColor.textPrimaryColor))
                              ]),
                          onChanged: (value) {
                            presenter.selectServiceDropDown(value);
                          },
                        ),
                      ),
                BlocBuilder<ServicesRegisterPresenter, DHState>(
                    builder: (context, state) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: AppColor.borderColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('DESCRIÇÃO').caption1_emphasized(
                                  style: const TextStyle(
                                      color: AppColor.textSecondaryColor),
                                ),
                                presenter.serviceEntity.isLiveOnApp
                                    ? const SizedBox.shrink()
                                    : Container(
                                        transform:
                                            Matrix4.translationValues(4, -6, 0),
                                        child: const Text(" (Opcional)")
                                            .caption1_regular(
                                                style: const TextStyle(
                                                    color: AppColor
                                                        .textTertiaryColor)))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              //cursorWidth: 0,
                              controller: descriptionController,
                              cursorColor: AppColor.iconPrimaryColor,
                              showCursor: true,
                              style: const TextStyle(
                                  color: AppColor.textPrimaryColor,
                                  fontFamily: 'CircularStd'),
                              smartDashesType: SmartDashesType.disabled,
                              decoration: const InputDecoration.collapsed(
                                  hintText:
                                      'Ex: Lavada simples interna e externa...',
                                  hintStyle: TextStyle(
                                      color: AppColor.textTertiaryColor,
                                      fontFamily: 'CircularStd')),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (text) {
                                presenter.serviceEntity.description = text;
                              },
                            ),
                          ],
                        ))),
                const SizedBox(
                  height: 4,
                ),
                BlocBuilder<ServicesRegisterPresenter, DHState>(
                  builder: (context, state) => DHTextField(
                    hint: "Ex: 2",
                    title: "Tempo do serviço em horas",
                    isOptional: !presenter.serviceEntity.isLiveOnApp,
                    keyboardType: TextInputType.number,
                    controller: timeController,
                    icon: Icons.timer_outlined,
                    onChanged: (text) {
                      presenter.serviceEntity.serviceTimeHours = text;
                    },
                    //  controller: nameController,
                  ),
                ),
                DHTextField(
                  hint: "Ex: 15",
                  isOptional: true,
                  title: "Dias de pós-vendas",
                  keyboardType: TextInputType.multiline,
                  icon: Icons.calendar_month_outlined,
                  onChanged: (text) {
                    presenter.serviceEntity.daysPosSales = text;
                  },
                  //  controller: nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ServicesRegisterPresenter, DHState>(
                    builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is DHLoadingState
                          ? () {}
                          : () async {
                              if (presenter.isValideToContinue()) {
                                bool? isServiceRegistered =
                                    await showModalBottomSheet<bool?>(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (_) => BlocProvider.value(
                                    value: presenter,
                                    child: isCreatingService
                                        ? ServicePricesBottomSheet.create()
                                        : ServicePricesBottomSheet.update(
                                            partnerServiceDto!,
                                          ),
                                  ),
                                );

                                if (isServiceRegistered != null &&
                                    isServiceRegistered) {
                                  // presenter.load();
                                }
                              } else {
                                DHSnackBar().showSnackBar(
                                    "Ops...",
                                    presenter.serviceEntity.isLiveOnApp
                                        ? "Você precisa preencher o serviço, descrição e tempo do serviço, caso deseja mostrar no App para os clientes da DriverHub"
                                        : "Selecione um serviço ou verifique o serviço selecionado para continuar",
                                    DHSnackBarType.error);
                              }
                            },
                      child: Text(isCreatingService ? "Continuar" : "Salvar"),
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
