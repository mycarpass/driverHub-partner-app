import 'package:flutter/material.dart';

abstract class LayoutInputBase extends StatelessWidget {
  const LayoutInputBase({super.key});

  SignUpStep get step;

  void action(BuildContext context);
}

enum SignUpStep { partnerData, email, emailCode, address, password, personData }

enum SignUpFields {
  establishment,
  cnpj,
  phone,
  name,
  cpf,
  addressNumber,
  email,
  confirmEmail,
  password
}
