import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabsHomeAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const TabsHomeAppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leadingWidth: double.infinity,
      leading: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            CustomIcons.logo,
            color: AppColor.accentColor,
          ),
        ],
      ),
      actions: [],
    );
  }
}
