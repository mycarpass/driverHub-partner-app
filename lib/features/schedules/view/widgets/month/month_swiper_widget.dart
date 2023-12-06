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
  void _changeMonth(DateTime _value) {
    setState(() {
      widget.selectedMonth = _value;
    });
  }

  String _formatDate(DateTime _value) {
    return DateFormat('MMMM y', 'pt_BR').format(_value).capitalize();
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
            widget.onChanged(widget.selectedMonth);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        Text(
          _formatDate(widget.selectedMonth),
        ).body_regular(),
        IconButton(
          onPressed: () {
            _changeMonth(
              widget.selectedMonth.add(
                const Duration(
                  days: 30,
                ),
              ),
            );
            widget.onChanged(widget.selectedMonth);
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
          ),
        )
      ],
    );
  }
}
