import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/router/schedules_router.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/month/month_swiper_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScheduledBodyWidget extends StatefulWidget {
  const CalendarScheduledBodyWidget({required this.schedules, super.key});

  final List<ScheduleDataDto> schedules;

  @override
  State<CalendarScheduledBodyWidget> createState() =>
      _CalendarScheduledBodyWidgetState();
}

class _CalendarScheduledBodyWidgetState
    extends State<CalendarScheduledBodyWidget> {
  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SchedulesPresenter>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            BlocBuilder<SchedulesPresenter, DHState>(builder: (context, state) {
          return Column(children: [
            MonthSwiperWidget(
                selectedMonth: presenter.selectedMonth,
                onChanged: (_) async {
                  await presenter.filterListByDate(_);
                }),
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

                // showModalBottomSheet<String>(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return BlocProvider.value(
                //           value: presenter,
                //           child: ScheduledListView(
                //               schedules: eventsList.isEmpty
                //                   ? []
                //                   : eventsList as List<ScheduleDataDto>));
                //       // return ContactInfoSheetWidget(
                //       //   onTapButton: () {
                //       //     Uri uri = Uri(
                //       //         host: "api.whatsapp.com",
                //       //         scheme: "https",
                //       //         path: "send",
                //       //         queryParameters: {
                //       //           "phone": "+5534984044391",
                //       //           "text":
                //       //               "[Fale conosco - DriverHub]: Gostaria de falar sobre..."
                //       //         });
                //       //     presenter.openUrl(uri);
                //       //   },
                //     });
              },
              firstDay: DateTime(presenter.selectedMonth.year,
                  presenter.selectedMonth.month, 1),
              lastDay: DateTime(presenter.selectedMonth.year,
                  presenter.selectedMonth.month + 1, 0),
            )
          ]);
        }));
  }
}
