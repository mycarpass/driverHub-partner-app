import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/profile/view/widgets/params/profile_card_row_param.dart';
import 'package:flutter/material.dart';

class ProfileCardRowWidget extends StatelessWidget {
  const ProfileCardRowWidget({
    super.key,
    required this.param,
  });
  final ProfileCardRowWidgetParam param;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: param.backgroundColor,
      elevation: 0,
      child: GestureDetector(
        onTap: () => param.onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Row(
            children: [
              param.leading,
              const SizedBox(
                width: 16,
              ),
              param.title,
              const Expanded(child: SizedBox.shrink()),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: param.arrowColor ?? AppColor.iconPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
