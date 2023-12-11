import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/profile/view/widgets/params/profile_card_row_param.dart';
import 'package:flutter/material.dart';

class ListProfileCardRowWidget extends StatelessWidget {
  const ListProfileCardRowWidget({super.key, required this.param});

  final List<ProfileCardRowWidgetParam> param;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.backgroundTransparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(left: 58.0),
            child: Divider(),
          ),
          itemCount: param.length,
          itemBuilder: (context, index) =>
              ProfileCardRowListItemWidget(param: param[index]),
        ),
      ),
    );
  }
}

class ProfileCardRowListItemWidget extends StatelessWidget {
  const ProfileCardRowListItemWidget({
    super.key,
    required this.param,
  });
  final ProfileCardRowWidgetParam param;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () => param.onPressed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
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
    );
  }
}
