import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';
import 'package:driver_hub_partner/features/pos_sales/presenter/pos_sales_presenter.dart';
import 'package:driver_hub_partner/features/pos_sales/router/pos_sales_router.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/month/month_swiper_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosSalesCalendarWidget extends StatelessWidget {
  const PosSalesCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<PosSalesPresenter>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<PosSalesPresenter, DHState>(
        builder: (context, state) {
          return Column(
            children: [
              MonthSwiperWidget(
                selectedMonth: presenter.selectedMonth,
                onChanged: (_) async {
                  await presenter.filterListByDate(_);
                },
              ),
              CalendarWidget(
                events: presenter.mapListFiltered,
                onSelectedDay: (selectedDay, eventsList) {
                  Navigator.pushNamed(
                    context,
                    PosSalesRoutes.posSalesList,
                    arguments: {
                      'sales': eventsList.isEmpty
                          ? null
                          : eventsList as List<PosSalesDto>,
                      'day': selectedDay
                    },
                  );
                },
                firstDay: DateTime(presenter.selectedMonth.year,
                    presenter.selectedMonth.month, 1),
                lastDay: DateTime(presenter.selectedMonth.year,
                    presenter.selectedMonth.month + 1, 0),
              )
            ],
          );
        },
      ),
    );
  }
}
