import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class CustomersErrorWidget extends StatelessWidget {
  const CustomersErrorWidget({super.key, required this.reload});

  final Function reload;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        const Icon(
          Icons.error_outline,
          color: AppColor.errorColor,
          size: 48,
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Não foi possível \ncarregar os clientes",
          textAlign: TextAlign.center,
        ).title3_regular(),
        TextButton(onPressed: () => reload(), child: Text("Recarregar"))
      ],
    ));
  }
}
