import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class CardDateReadOnly extends StatelessWidget {
  const CardDateReadOnly({
    super.key,
    required this.date,
    this.showArrowIcon = true,
  });

  final String date;
  final bool showArrowIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.35),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  CustomIcons.dhCalendarOutlined,
                  color: AppColor.textTertiaryColor,
                  size: 16,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text("Data do serviço").body_bold(
                  style: const TextStyle(
                    color: AppColor.textPrimaryColor,
                  ),
                ),
                Text("・$date").body_regular(
                  style: const TextStyle(
                    color: AppColor.textTertiaryColor,
                  ),
                )
              ],
            ),
            showArrowIcon
                ? const Icon(
                    Icons.chevron_right,
                    color: AppColor.textTertiaryColor,
                    size: 20,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
