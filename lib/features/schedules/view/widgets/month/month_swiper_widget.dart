import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/commom_objects/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MonthSwiperWidget extends StatefulWidget {
  MonthSwiperWidget({
    super.key,
    required this.selectedMonth,
    required this.onChanged,
  });
  DateTime selectedMonth;

  final Function(DateTime month) onChanged;

  @override
  State<MonthSwiperWidget> createState() => _MonthSwiperWidgetState();
}

class _MonthSwiperWidgetState extends State<MonthSwiperWidget> {
  void _changeMonth(DateTime value) {
    setState(() {
      widget.selectedMonth = value;
    });
    widget.onChanged(widget.selectedMonth);
  }

  String _formatDate(DateTime value) {
    return DateFormat('MMMM y', 'pt_BR').format(value).capitalize();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            _changeMonth(
              widget.selectedMonth.subtract(
                const Duration(
                  days: 30,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.iconPrimaryColor,
            size: 20,
          ),
        ),
        Text(
          _formatDate(widget.selectedMonth),
        ).body_bold(),
        IconButton(
          onPressed: () {
            _changeMonth(
              widget.selectedMonth.add(
                const Duration(
                  days: 30,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: AppColor.iconPrimaryColor,
            size: 20,
          ),
        )
      ],
    );
  }
}
