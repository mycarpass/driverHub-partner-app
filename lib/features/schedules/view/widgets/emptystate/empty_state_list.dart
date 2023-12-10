import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyStateList extends StatelessWidget {
  const EmptyStateList({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            const Icon(
              CustomIcons.dhCanceled,
              size: 48,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ).body_regular()
          ],
        ));
  }
}
