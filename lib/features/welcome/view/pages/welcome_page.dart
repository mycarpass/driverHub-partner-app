import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/login/router/login_routes.dart';
import 'package:driver_hub_partner/features/welcome/view/resources/welcome_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                "lib/assets/images/LogoWhite.svg",
              ),
              const SizedBox(
                height: 12,
              ),
              const Text('Cuidar do seu carro nunca foi tão fácil')
                  .body_regular(
                      style:
                          const TextStyle(color: AppColor.textTertiaryColor)),
              const SizedBox(
                height: 106,
              ),
              ElevatedButton(
                key: WelcomeKeys.signUpButtonKey,
                onPressed: () {},
                // Navigator.pushNamed(context, SignUpRoutes.name),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Começar"),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  key: WelcomeKeys.alreadyhasAnAccountKey,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginRoutes.login),
                  child: const Text("Ja tenho uma conta").label2_bold(
                      style: const TextStyle(color: AppColor.accentColor))),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
