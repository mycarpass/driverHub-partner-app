import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/bottomsheets/customer_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/card_date_read_only.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/ligh_dh_date_picker.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/drop_down/customer_drop_down_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/drop_down/service_drop_down_widget.dart';
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
    return BlocProvider(
      create: (context) => CreateSchedulePresenter(),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              const Text("Adicionar agendamento").title1_bold(),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  var result = await showModalBottomSheet(
                    context: context,
                    builder: (context) => LighDHDatePickerBottomSheet(
                      initialDate: DateTime.now(),
                    ),
                  );
                  if (result != null) {
                    context
                        .read<CreateSchedulePresenter>()
                        .updateServiceDate(result);
                  }
                },
                child: BlocBuilder<CreateSchedulePresenter, DHState>(
                    builder: (context, state) {
                  return CardDateReadOnly(
                    date: context
                        .read<CreateSchedulePresenter>()
                        .serviceDate
                        .rawDate,
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              DHTextField(
                hint: "08:00",
                formatters: [hourFormatter],
                icon: Icons.timer,
                onChanged: (hour) {
                  context.read<CreateSchedulePresenter>().setScheduleHour(hour);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ServicesDropDownWidget.onlyRegisteredServices(
                      controller: servicesDropDownController,
                      onChanged: (serviceSelected) {
                        context
                            .read<CreateSchedulePresenter>()
                            .setScheduleService(serviceSelected);
                      },
                    ),
                  ),
                  TextButton(
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
                      child: Text("+ Novo"))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomerDropDownWidget(
                      controller: customerDropDownController,
                      onChanged: (customer) {
                        context
                            .read<CreateSchedulePresenter>()
                            .setScheduleCustomer(customer);
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      bool? isCustomerRegistered =
                          await showModalBottomSheet<bool?>(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        builder: (_) => CustomerRegisterBottomSheet(),
                      );

                      if (isCustomerRegistered != null &&
                          isCustomerRegistered) {
                        customerDropDownController.load();
                      }
                    },
                    child: Text("+ Novo"),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
