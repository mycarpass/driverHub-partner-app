import 'package:flutter/material.dart';

abstract class LayoutInputBase extends StatelessWidget {
  const LayoutInputBase({super.key});

  SignUpStep get step;

  void action(BuildContext context);
}

enum SignUpStep { name, email, emailCode, phone, password, gender, personName }
