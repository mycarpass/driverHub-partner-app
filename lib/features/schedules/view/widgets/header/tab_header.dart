import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class TabViewHeader extends StatelessWidget {
  const TabViewHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });
  final String title;
  final String subtitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title).title1_bold(),
            const SizedBox(
              height: 4,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(subtitle).body_regular())
          ],
        ),
        TextButton(
          onPressed: () => onPressed(),
          child: Row(
            children: [
              const Icon(
                Icons.add_outlined,
                color: AppColor.accentColor,
                size: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Novo").label1_bold(
                  style: const TextStyle(color: AppColor.accentColor)),
            ],
          ),
        )
      ],
    );
  }
}
