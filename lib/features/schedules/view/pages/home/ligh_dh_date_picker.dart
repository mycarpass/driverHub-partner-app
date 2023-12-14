import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:flutter/material.dart';

class LighDHDatePickerBottomSheet extends StatelessWidget {
  const LighDHDatePickerBottomSheet({super.key, required this.initialDate});

  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColor.accentColor,
          onPrimary: AppColor.accentColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColor.accentColor,
            ),
            foregroundColor: AppColor.accentColor, // button text color
          ),
        ),
      ),
      child: DatePickerTheme(
        data: DatePickerThemeData(
          yearBackgroundColor: MaterialStateProperty.all(
            AppColor.blackColor.withOpacity(0.5),
          ),
          yearForegroundColor: MaterialStateProperty.all(
            AppColor.whiteColor,
          ),
          dayStyle: const TextStyle(color: Colors.red),
          weekdayStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 13,
            color: Colors.black,
          ),
          yearStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
          headerHelpStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
          headerHeadlineStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
          rangePickerHeaderHelpStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
          rangePickerHeaderHeadlineStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
          dayForegroundColor: MaterialStateProperty.all(Colors.black),
          elevation: 0,
          headerBackgroundColor: Colors.transparent,
          todayForegroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 9, 95, 79),
          ),
          todayBackgroundColor: MaterialStateProperty.all(
            Colors.transparent,
          ),
          todayBorder: BorderSide.none,
          yearOverlayColor: MaterialStateProperty.all(AppColor.blackColor),
          headerForegroundColor: AppColor.blackColor,
          rangeSelectionOverlayColor:
              MaterialStateProperty.all(AppColor.accentHoverColor),
          dayOverlayColor: MaterialStateProperty.all(AppColor.accentHoverColor),
        ),
        child: DatePickerDialog(
          initialCalendarMode: DatePickerMode.day,
          initialDate: initialDate,
          firstDate: initialDate,
          cancelText: "Voltar",
          confirmText: "Pronto",
          helpText: "Data do serviço",
          lastDate: DateTime.now().add(
            const Duration(days: 90),
          ),
        ),
      ),
    );
  }
}
