// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget(
      {required this.firstDay,
      required this.lastDay,
      required this.onSelectedDay,
      required this.events,
      super.key});

  final DateTime firstDay;
  final DateTime lastDay;
  final Map<DateTime, List> events;

  final Function(DateTime selectedDay, List<dynamic> eventsList) onSelectedDay;

  @override
  // ignore: library_private_types_in_public_api
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarFormat _calendarFormat =
      CalendarFormat.month; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  dynamic kEvents;

  @override
  void initState() {
    super.initState();
    kEvents = LinkedHashMap<DateTime, List<dynamic>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(widget.events);

    _selectedDay = _focusedDay;
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    widget.onSelectedDay(selectedDay, _getEventsForDay(selectedDay));
    if (!isSameDay(_selectedDay, selectedDay)) {
      // setState(() {
      //   _selectedDay = selectedDay;
      //   _focusedDay = focusedDay;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<dynamic>(
      locale: 'pt_BR',
      firstDay: widget.firstDay,
      lastDay: widget.lastDay,
      focusedDay: widget.firstDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      calendarFormat: _calendarFormat,
      eventLoader: _getEventsForDay,
      rowHeight: 55,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      headerVisible: false,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return Container(
                transform: Matrix4.translationValues(8, -2, 0),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: AppColor.supportColor, shape: BoxShape.circle),
                child: Text(events.length.toString()).caption2_bold(
                    style: const TextStyle(color: AppColor.backgroundColor)));
          }
          return null;
        },
      ),
      calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16,
              color: AppColor.textSecondaryColor),
          holidayTextStyle: TextStyle(fontFamily: 'CircularStd', fontSize: 16),
          disabledTextStyle: TextStyle(fontFamily: 'CircularStd', fontSize: 16),
          weekendTextStyle: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16,
              color: AppColor.textTertiaryColor),
          todayTextStyle: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16,
              color: AppColor.backgroundColor),
          todayDecoration: BoxDecoration(
              color: AppColor.supportColor, shape: BoxShape.circle),
          selectedTextStyle: TextStyle(fontFamily: 'CircularStd', fontSize: 16),
          selectedDecoration: BoxDecoration(
              color: AppColor.accentColor, shape: BoxShape.circle),
          isTodayHighlighted: true,
          canMarkersOverflow: true),
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
