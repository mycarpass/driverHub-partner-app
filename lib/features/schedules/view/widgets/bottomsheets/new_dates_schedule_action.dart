import 'package:chips_choice/chips_choice.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewDatesScheduleWidget extends StatefulWidget {
  const NewDatesScheduleWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewDatesScheduleWidgetState createState() => _NewDatesScheduleWidgetState();
}

class _NewDatesScheduleWidgetState extends State<NewDatesScheduleWidget> {
  final TextEditingController controller = TextEditingController();
  DateTime dateSelected = DateTime.now();
  List<String> hoursSelected = [];
  List<String> hours = ['08:00', '10:30', '13:30', '16:00'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            AppBar().modalAppBar(
                title: 'Sugira novos horários',
                backButtonsIsVisible: false,
                doneButtonIsVisible: false),
            Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Faça uma sugestão de uma nova data e horário para esse agendamento',
                        textAlign: TextAlign.center,
                      ).body_regular(
                          style: const TextStyle(
                              color: AppColor.textSecondaryColor)),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text('Selecione uma data').body_bold(),
                      const SizedBox(
                        height: 16,
                      ),
                      EasyInfiniteDateTimeLine(
                        focusDate: dateSelected,
                        locale: "pt_BR",
                        firstDate: DateTime.now(),
                        showTimelineHeader: false,
                        lastDate: DateTime.now().add(const Duration(days: 4)),
                        onDateChange: (selectedDate) {
                          setState(() {
                            hoursSelected = [];
                            dateSelected = selectedDate;
                          });
                          //`selectedDate` the new date selected.
                        },
                        dayProps: const EasyDayProps(
                          height: 56.0,
                          // You must specify the width in this case.
                          width: 124.0,
                        ),
                        itemBuilder: (BuildContext context, String dayNumber,
                            dayName, monthName, fullDate, isSelected) {
                          return Container(
                            //the same width that provided previously.
                            width: 124.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isSelected
                                      ? AppColor.accentColor
                                      : AppColor.borderColor),
                              color: isSelected
                                  ? AppColor.accentColor.withOpacity(0.6)
                                  : null,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dayName).caption1_regular(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColor.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(dayNumber).title2_bold(
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColor.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(monthName).caption1_regular(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColor.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text('Escolha 1 ou mais horários disponíveis')
                          .body_bold(),
                      const SizedBox(
                        height: 16,
                      ),
                      ChipsChoice<String>.multiple(
                        padding: EdgeInsets.zero,
                        value: hoursSelected,
                        choiceBuilder: (item, i) {
                          bool itemDisabled = false;
                          DateTime today = DateTime.now();
                          if (dateSelected.day == today.day) {
                            if (item.label == "08:00") {
                              itemDisabled = true;
                            } else if (item.label == "10:30") {
                              itemDisabled = today.hour > 10;
                            } else if (item.label == "13:30") {
                              itemDisabled = today.hour > 13;
                            } else if (item.label == "16:00") {
                              itemDisabled = today.hour > 15;
                            } else {
                              itemDisabled = false;
                            }
                          }
                          return Container(
                              //the same width that provided previously.
                              width: 124.0,
                              height: 48,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: item.selected
                                        ? AppColor.accentColor
                                        : AppColor.borderColor),
                                color: itemDisabled
                                    ? AppColor.borderColor
                                    : item.selected
                                        ? AppColor.accentColor.withOpacity(0.6)
                                        : null,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                    // tapTargetSize:
                                    //     MaterialTapTargetSize.shrinkWrap,
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )),
                                    elevation:
                                        const MaterialStatePropertyAll(0),
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: itemDisabled
                                    ? null
                                    : () => item.select!(!item.selected),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item.label).label2_regular(
                                      style: TextStyle(
                                        // fontSize: 20,
                                        color: item.selected
                                            ? Colors.white
                                            : AppColor.textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                        onChanged: (val) => setState(() => hoursSelected = val),
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: hours,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (hoursSelected.isEmpty) {
                            DHSnackBar().showSnackBar(
                                "Atenção",
                                "Escolha ao menos um horário para sugestão.",
                                DHSnackBarType.warning);
                          } else {
                            RequestNewHoursSuggest requestNewHoursSuggest =
                                RequestNewHoursSuggest();
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(dateSelected);
                            for (var hourSelected in hoursSelected) {
                              NewHourSuggestion newHourSuggestion =
                                  NewHourSuggestion(
                                      date: formattedDate,
                                      timeSuggestion: hourSelected);
                              requestNewHoursSuggest.newDateSuggestions
                                  .add(newHourSuggestion);
                            }

                            Navigator.pop(
                              context,
                              requestNewHoursSuggest,
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sugerir novos horários'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                          child: TextButton(
                              onPressed: () => Navigator.pop(
                                    context,
                                    null,
                                  ),
                              child: const Text("Cancelar").label2_bold(
                                  style: const TextStyle(
                                      color: AppColor.accentColor)))),
                    ]))
          ]),
        ));
  }
}
