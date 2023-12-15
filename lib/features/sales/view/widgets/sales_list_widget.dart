import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/commom_objects/extensions/date_extensions.dart';
import 'package:driver_hub_partner/features/sales/presenter/sales_presenter.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/sales_list_item_widget.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/month/month_swiper_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/solicitation_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesListWidget extends StatelessWidget {
  const SalesListWidget({required this.sales, super.key});

  final List<dynamic> sales;

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SalesPresenter>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<SalesPresenter, DHState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MonthSwiperWidget(
                selectedMonth: presenter.selectedMonth,
                onChanged: (_) {
                  presenter.filterListByDate(_);
                },
              ),
              sales.isEmpty
                  ? const EmptyStateList(
                      text: 'Nenhuma venda encontrado para o mês selecionado.',
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        presenter.filteredList.isEmpty
                            ? const EmptyStateList(
                                text:
                                    'Nenhuma venda encontrado para o mês selecionado.',
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 32),
                                itemCount: presenter.filteredList.length,
                                itemBuilder: (context, index) {
                                  bool isSameDate = true;
                                  final DateTime date =
                                      presenter.filteredList[index].saleDate;

                                  if (index == 0) {
                                    isSameDate = false;
                                  } else {
                                    final DateTime prevDate = presenter
                                        .filteredList[index - 1].saleDate;
                                    isSameDate = date.isSameDate(prevDate);
                                  }
                                  if (index == 0 || !(isSameDate)) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            presenter
                                                .filteredList[index].saleDate
                                                .formatDate(
                                              'dd, EEEE',
                                              'pt_BR',
                                            ),
                                          ).body_bold(),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SalesListItemWidget(
                                            solicitationDataDto:
                                                presenter.filteredList[index],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                    // return SolicitationListItemWidget(
                                    //   solicitationDataDto:
                                    //       presenter.filteredList[index],
                                    // );
                                  }
                                },
                              ),
                      ],
                    )
            ],
          );
        },
      ),
    );
  }
}
