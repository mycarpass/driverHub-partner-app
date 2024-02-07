import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/receivable_dto.dart';
import 'package:driver_hub_partner/features/home/presenter/receivable_presenter.dart';
import 'package:driver_hub_partner/features/home/router/home_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReceivableCardWidget extends StatefulWidget {
  const ReceivableCardWidget({super.key});

  @override
  State<ReceivableCardWidget> createState() => _ReceivableCardWidgetState();
}

class _ReceivableCardWidgetState extends State<ReceivableCardWidget> {
  ReceivablePresenter presenter = ReceivablePresenter();

  @override
  void initState() {
    presenter.getReceivable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: presenter,
      child: Builder(builder: (context) {
        return Card(
          color: AppColor.backgroundTransparent,
          elevation: 0,
          child: BlocBuilder<ReceivablePresenter, DHState>(
              builder: (context, state) {
            if (state is! DHSuccessState) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const DHSkeleton(
                  child: ReceivableLoadingBody(),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(
                      Icons.call_received,
                      color: AppColor.iconSecondaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Recebíveis").body_bold(),
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              HomeRoutes.receivableHistoric,
                              arguments: presenter.receivableDto.historic);
                        },
                        child: const Text("ver todos"))
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(presenter.receivableDto.actualMonth).body_regular(),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: LinearPercentIndicator(
                      animation: true,
                      percent: presenter.receivableDto.isSubscriptionActive
                          ? 1
                          : presenter.receivableDto.getPercentToActive(),
                      progressColor: AppColor.accentColor,
                      lineHeight: 50,
                      barRadius: const Radius.circular(12),
                      center: Text(presenter.receivableDto.isSubscriptionActive
                              ? "Acesso Completo ativado"
                              : "50%")
                          .caption1_bold(
                              style:
                                  const TextStyle(color: AppColor.whiteColor)),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  presenter.receivableDto.isSubscriptionActive
                      ? Center(
                          child: const Text(
                                  "Acesso completo liberado até o fim do mês")
                              .caption1_regular())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Retido para liberar Acesso Completo")
                                .body_regular(),
                            Text(presenter.receivableDto.totalAmountWithheld
                                    .priceInReal)
                                .title3_bold()
                          ],
                        ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text("À receber da DriverHub").body_regular(),
                      const Expanded(child: SizedBox.shrink()),
                      Text(
                        presenter.receivableDto.totalAmountEarned.priceInReal,
                      ).title2_bold()
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}

class ReceivableLoadingBody extends StatelessWidget {
  const ReceivableLoadingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: 350,
        color: Colors.grey,
      ),
    );
  }
}
