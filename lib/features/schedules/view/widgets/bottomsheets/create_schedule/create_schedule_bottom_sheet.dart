import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/customers/presenter/cutomer_register_presenter.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/bottomsheets/customer_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/card_date_read_only.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/ligh_dh_date_picker.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/alter_service_price/alter_service_price_bottomsheet.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/cerate_schedule_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/drop_down/customer_drop_down_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/drop_down/service_drop_down_widget.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/view/widgets/bottomsheets/service_register_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateScheduleBottomSheet extends StatelessWidget {
  CreateScheduleBottomSheet({
    super.key,
  });

  final MaskTextInputFormatter hourFormatter = MaskTextInputFormatter(
    mask: "##:##",
    initialText: "10:00",
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  final ServicesDropDownController servicesDropDownController =
      ServicesDropDownController();

  final CustomerDropDownController customerDropDownController =
      CustomerDropDownController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.85,
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => CreateSchedulePresenter(),
            child: Builder(builder: (context) {
              var presenter = context.read<CreateSchedulePresenter>();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Text("Adicionar agendamento").label1_bold(),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          builder: (context) => SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.85,
                            child: LighDHDatePickerBottomSheet(
                              currentDate: DateTime.now(),
                            ),
                          ),
                        );
                        if (result != null) {
                          presenter.updateServiceDate(result);
                        }
                      },
                      child: BlocConsumer<CreateSchedulePresenter, DHState>(
                          listener: (context, state) {
                        if (state is DHErrorState) {
                          DHSnackBar().showSnackBar(
                              "Opss..",
                              "Não foi possível criar seu agendamento, tente novamente mais tarde",
                              DHSnackBarType.error);
                        } else if (state is NewScheduleCreatedState) {
                          Navigator.of(context).pop(true);
                        }
                      }, builder: (context, state) {
                        return CardDateReadOnly(
                          date: presenter.serviceDate.rawDate,
                        );
                      }),
                    ),
                    DHTextField(
                      title: "Horário",
                      hint: "08:00",
                      formatters: [hourFormatter],
                      icon: Icons.timer,
                      keyboardType: TextInputType.number,
                      onChanged: (hour) {
                        presenter.setScheduleHour(hour);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomerDropDownWidget(
                            controller: customerDropDownController,
                            onChanged: (customer) {
                              presenter.setScheduleCustomer(customer);
                              presenter.recalculateService();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Center(
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: AppColor.accentColor,
                            onPressed: () async {
                              bool? isCustomerRegistered =
                                  await showModalBottomSheet<bool?>(
                                context: context,
                                showDragHandle: true,
                                isScrollControlled: true,
                                builder: (_) => BlocProvider(
                                  create: (context) =>
                                      CustomerRegisterPresenter(),
                                  child: CustomerRegisterBottomSheet(),
                                ),
                              );

                              if (isCustomerRegistered != null &&
                                  isCustomerRegistered) {
                                customerDropDownController.load();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: BlocBuilder<CreateSchedulePresenter, DHState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: presenter.scheduleEntity.customerDto
                                    .isVehicleNull() ||
                                presenter.scheduleEntity.customerDto
                                        .manualBodyTypeSelected !=
                                    null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                        "Qual a carroceria do carro do cliente?")
                                    .body_bold(),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  // width: 80,
                                  height: 60,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 16,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () =>
                                          presenter.manualSetOfCarBodyType(
                                        CarBodyType.values[index],
                                      ),
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: presenter.scheduleEntity
                                                      .matchCustomerCarBodyType(
                                                          CarBodyType
                                                              .values[index])
                                                  ? AppColor.accentColor
                                                  : AppColor.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                              CarBodyType.values[index].value),
                                        ),
                                      ),
                                    ),
                                    itemCount: CarBodyType.values.length,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    BlocBuilder<CreateSchedulePresenter, DHState>(
                        builder: (context, state) {
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: presenter.scheduleEntity
                                .isCustomerAndVehicleAlreadySetted()
                            ? 1
                            : 0,
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  ServicesDropDownWidget.onlyRegisteredServices(
                                controller: servicesDropDownController,
                                onChanged: (serviceSelected) {
                                  presenter.addScheduleService(serviceSelected);
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                bool? isServiceRegistered =
                                    await showModalBottomSheet<bool?>(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (_) => BlocProvider(
                                      create: (context) =>
                                          ServicesRegisterPresenter()..load(),
                                      child: ServiceRegisterBottomSheet()),
                                );
                                if (isServiceRegistered != null &&
                                    isServiceRegistered) {
                                  servicesDropDownController.load();
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                color: AppColor.accentColor,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    BlocBuilder<CreateSchedulePresenter, DHState>(
                      builder: (context, state) => presenter
                              .scheduleEntity.services.isNotEmpty
                          ? SizedBox(
                              height: 160,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
                                        child: Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      presenter.scheduleEntity
                                                          .services[index].name,
                                                    ).body_bold(),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () => presenter
                                                          .removeScheduleService(
                                                        presenter.scheduleEntity
                                                            .services[index],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                    "Veículo: ${presenter.scheduleEntity.customerDto.vehicle?.model ?? 'Não informado'}"),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Preço: ${presenter.getPriceByCarBodyType(presenter.scheduleEntity.services[index]).priceInReal}",
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        var newPrice =
                                                            await showModalBottomSheet(
                                                          context: context,
                                                          showDragHandle: true,
                                                          isScrollControlled:
                                                              true,
                                                          builder: (context) {
                                                            return AlterServicePriceBottomSheet(
                                                                initialValue: presenter
                                                                    .getPriceByCarBodyType(presenter
                                                                        .scheduleEntity
                                                                        .services[index])
                                                                    .price);
                                                          },
                                                        );

                                                        if (newPrice != null) {
                                                          presenter.alterPrice(
                                                              presenter
                                                                  .scheduleEntity
                                                                  .services[index],
                                                              newPrice);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit_outlined,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 8,
                                      ),
                                  itemCount:
                                      presenter.scheduleEntity.services.length),
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocBuilder<CreateSchedulePresenter, DHState>(
                          builder: (context, state) {
                        return AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: presenter.scheduleEntity
                                    .isCustomerAndVehicleAlreadySetted()
                                ? 1
                                : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total:").label2_bold(),
                                Text(presenter.moneyController.text)
                                    .label2_bold(),
                              ],
                            )
                            //  DHTextField(
                            //   hint: "Total",
                            //   icon: Icons.monetization_on,
                            //   controller: presenter.moneyController,
                            //   keyboardType: TextInputType.number,
                            //   disabled: true,
                            //   onChanged: (_) {
                            //     context.read<CreateSchedulePresenter>().setValue(_);
                            //   },
                            // ),
                            );
                      }),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<CreateSchedulePresenter, DHState>(
                        builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () =>
                            presenter.scheduleEntity.isEverythingFilled()
                                ? presenter.sendSchedule()
                                : DHSnackBar().showSnackBar(
                                    "Opss..",
                                    "Preencha todos o dados",
                                    DHSnackBarType.warning,
                                  ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            state is DHLoadingState
                                ? const DHCircularLoading()
                                : const Text("Criar"),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
