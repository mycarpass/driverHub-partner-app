import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sales/presenter/sales_presenter.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/router/schedules_router.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/month/month_swiper_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesCalendarWidget extends StatelessWidget {
  const SalesCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SalesPresenter>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<SalesPresenter, DHState>(
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
                    SchedulesRoutes.scheduleList,
                    arguments: {
                      'schedules': eventsList.isEmpty
                          ? null
                          : eventsList as List<ScheduleDataDto>,
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
