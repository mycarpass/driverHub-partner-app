import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedule_payments_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

class SchedulePaymentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchedulePaymentsPresenter(),
      child: Builder(builder: (context) {
        var presenter = context.read<SchedulePaymentsPresenter>()
          ..load(DateTime.now());
        return Scaffold(
          appBar: AppBar().backButton(),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<SchedulePaymentsPresenter, DHState>(
                    builder: (context, state) {
                  if (state is DHLoadingState) {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) => DHSkeleton(
                        child: Container(
                          color: Colors.red,
                          height: 80,
                        ),
                      ),
                      itemCount: 7,
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Pagamentos à receber").label1_bold(),
                          TextButton(
                            onPressed: () {
                              showMonthPicker(
                                context,
                                onSelected: (month, year) {
                                  presenter.load(DateTime.now());
                                },
                                initialSelectedMonth: 1,
                                initialSelectedYear: DateTime.now().year,
                                firstYear: DateTime.now().year,
                                lastYear: 2026,
                                firstEnabledMonth: 1,
                                lastEnabledMonth: 12,
                                selectButtonText: 'OK',
                                cancelButtonText: 'Cancel',
                                highlightColor: AppColor.accentColor,
                                textColor: Colors.black,
                                contentBackgroundColor: Colors.white,
                                dialogBackgroundColor: Colors.grey[200],
                              );
                            },
                            child: const Text("Mês"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 32.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.monetization_on),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Container(
                                      height: 85,
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("01/12/23").body_bold(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Vitrificação").body_bold(),
                                        const Text("R\$ 100,00").body_bold()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Previsão de saque")
                                            .body_bold(),
                                        const Text("01/01/24").body_bold()
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 8,
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
