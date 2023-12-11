import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyStateList extends StatelessWidget {
  const EmptyStateList({
    required this.text,
    this.padding,
    super.key,
  });

  final String text;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
        child: Column(
          children: [
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
