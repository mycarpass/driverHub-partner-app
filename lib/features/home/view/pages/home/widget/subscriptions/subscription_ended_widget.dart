import 'dart:ui';

import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionEndedWidget extends StatefulWidget {
  const SubscriptionEndedWidget({
    super.key,
  });

  @override
  State<SubscriptionEndedWidget> createState() =>
      _SubscriptionEndedWidgetState();
}

class _SubscriptionEndedWidgetState extends State<SubscriptionEndedWidget> {
  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SubscriptionPresenter>();
    return presenter.isSubscribed
        ? const SizedBox.shrink()
        : BlocProvider(
            create: (context) => SubscriptionPresenter(),
            child: AbsorbPointer(
                absorbing: false,
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColor.iconSecondaryColor),
                      child: Center(
                          child: Container(
                              margin: const EdgeInsets.all(24),
                              width: double.infinity,
                              height: 240,
                              child: Column(
                                children: [
                                  const Icon(
                                    CustomIcons.dhCrown,
                                    size: 48,
                                    color: AppColor.supportColor,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  const Text(
                                    'Sua assinatura expirou!',
                                    textAlign: TextAlign.center,
                                  ).body_bold(
                                      style: const TextStyle(
                                          color: AppColor.whiteColor)),
                                  const Text(
                                    'Clique abaixo para assinar e continuar usando normalmente.',
                                    textAlign: TextAlign.center,
                                  ).body_regular(
                                      style: const TextStyle(
                                          color: AppColor.whiteColor)),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        presenter.openPayWall(context);
                                      },
                                      child: const Text('Quero assinar'))
                                ],
                              ))),
                    ))));
  }
}
