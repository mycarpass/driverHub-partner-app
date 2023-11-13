import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class TabIconWidget extends StatelessWidget {
  const TabIconWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.onClick,
      required this.indexOfTab,
      this.selectedTab = 0});

  final IconData icon;
  final String text;
  final Function(int) onClick;
  final int selectedTab;
  final int indexOfTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => onClick(indexOfTab),
          splashRadius: 32,
          icon: Icon(
            icon,
            size: 24,
            color: selectedTab == indexOfTab
                ? AppColor.accentColor
                : AppColor.textTertiaryColor,
          ),
        ),
        selectedTab == indexOfTab
            ? Container(
                transform: Matrix4.translationValues(0, -4, 0),
                child: Text(text).caption2_bold(
                  style: const TextStyle(color: AppColor.accentColor),
                ),
              )
            : Container(
                transform: Matrix4.translationValues(0, -4, 0),
                child: Text(text).caption2_regular(
                  style: const TextStyle(color: AppColor.textTertiaryColor),
                ),
              )
      ],
    );
  }
}
