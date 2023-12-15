import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({super.key, required this.reload});

  final Function reload;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: AppColor.errorColor,
          size: 32,
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Não foi possível carregar a home",
          textAlign: TextAlign.center,
        ).title1_regular(),
        TextButton(onPressed: () => reload(), child: Text("Recarregar"))
      ],
    );
  }
}
