import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SubscriptionHomeCard extends StatefulWidget {
  SubscriptionHomeCard({
    required this.daysTrialLeft,
    super.key,
  });

  int daysTrialLeft = 0;

  @override
  State<SubscriptionHomeCard> createState() => _SubscriptionHomeCardState();
}

class _SubscriptionHomeCardState extends State<SubscriptionHomeCard> {
  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SubscriptionPresenter>();
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const MaterialStatePropertyAll(
                EdgeInsets.fromLTRB(16, 16, 16, 16),
              ),
              backgroundColor: MaterialStatePropertyAll(
                  widget.daysTrialLeft <= 0
                      ? AppColor.warningColor
                      : AppColor.successColor)),
          onPressed: () async {
            // if (widget.daysTrialLeft <= 0) {
            //   presenter.openPayWall(context);
            // }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(
                  CustomIcons.dhStarFill,
                  color: AppColor.iconSecondaryColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.daysTrialLeft <= 0
                        ? "Seu teste gratuito acabou :|"
                        : "Seu teste gratuito acaba em ${widget.daysTrialLeft} dia(s)")
                    .body_bold(),
                const Expanded(child: SizedBox.shrink()),
              ]),
              const SizedBox(
                height: 8,
              ),
              Text(widget.daysTrialLeft <= 0
                      ? "Clique para assinar e volte a usar de onde parou :)"
                      : "Clique para aproveitar o desconto e assinar agora!")
                  .caption1_regular(),
            ],
          )),
    );
  }
}
