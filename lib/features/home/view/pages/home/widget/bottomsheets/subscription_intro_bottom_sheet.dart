import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/home/view/resources/home_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionIntroBottomSheet extends StatelessWidget {
  const SubscriptionIntroBottomSheet({required this.storeProducts, super.key});

  final List<StoreProduct> storeProducts;

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SubscriptionPresenter>();
    return BlocBuilder<SubscriptionPresenter, DHState>(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.82,
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        // const BottomSheetHeader(),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                            height: 80,
                            width: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(99)),
                                  border: Border.all(
                                      color: AppColor.accentColor, width: 1.5)),
                              child: Image.asset(
                                HomeResources.hubClubLogo,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Seja um parceiro DriverHub, confira os benefícios ",
                          textAlign: TextAlign.center,
                        ).title2_bold(),
                        const SizedBox(
                          height: 32,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Gestão de clientes",
                          serviceDescription:
                              "Ofereça uma experiência inovadora aos seus clientes",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Agendamentos",
                          serviceDescription:
                              "Seus agendamentos na palma da mão, papel nunca mais!",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Controle de vendas",
                          serviceDescription:
                              "Venda mais e melhor, ajudamos você a fazer mais vendas com seu controle de vendas.",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Taxa pela metade",
                          serviceDescription:
                              "Os clientes que vierem pelo app da DriverHub, a taxa é de 10% por serviço e não mais 20%",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Novos clientes",
                          serviceDescription:
                              "Nós vamos atrás e divulgamos para mais clientes sua empresa em nosso app para clientes",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Financeiro",
                          serviceDescription:
                              "Seu financeiro sob-controle, saiba quanto está ganhando, qual serviço que mais vende, etc.",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Pós venda",
                          serviceDescription:
                              "Nós automatizamos e criamos um pós venda para você nunca mais deixar dinheiro na mesa.",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const _SubscriptionBenefitWidget(
                          assetPath: HomeResources.hubClubLogo,
                          serviceName: "Comunicação com clientes",
                          serviceDescription:
                              "Vamos facilitar e automatizar as comunicações com seus clientes, gerando alta fidelização.",
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        const Text("Cancele quando quiser. Sem taxa, sem multa")
                            .body_regular(),
                        const SizedBox(
                          height: 16,
                        ),

                        BlocBuilder<SubscriptionPresenter, DHState>(
                            builder: (context, state) => ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: storeProducts.length,
                                  padding: const EdgeInsets.only(bottom: 20),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 12,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                        style: ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))),
                                            padding:
                                                const MaterialStatePropertyAll(
                                                    EdgeInsets.zero)),
                                        onPressed: () async {
                                          await presenter.selectPlan(index);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16)),
                                              border: Border.all(
                                                  color: presenter
                                                              .indexPlanSelected ==
                                                          index
                                                      ? AppColor.accentColor
                                                      : AppColor.borderColor)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(presenter
                                                                  .indexPlanSelected ==
                                                              index
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .circle_outlined),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(storeProducts[index]
                                                              .title
                                                              .split(" ")[0])
                                                          .body_bold()
                                                    ],
                                                  ),
                                                  index == 1
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(6,
                                                                  4, 6, 4),
                                                          decoration: const BoxDecoration(
                                                              color: AppColor
                                                                  .supportColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              8))),
                                                          child: const Text(
                                                                  'Mais comprado')
                                                              .caption2_bold())
                                                      : const SizedBox.shrink()
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(storeProducts[index]
                                                      .description)
                                                  .body_regular(),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(children: [
                                                Text(storeProducts[index]
                                                        .priceString)
                                                    .label1_regular(),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(storeProducts[index]
                                                                .title
                                                                .split(
                                                                    " ")[0] ==
                                                            "Mensal"
                                                        ? '/ mês'
                                                        : '/ ano')
                                                    .body_regular()
                                              ])
                                            ],
                                          ),
                                        ));
                                  },
                                )),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              presenter.purchase(
                                  storeProducts[presenter.indexPlanSelected]);
                            },
                            child: const Text("Assinar agora"),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                            onPressed: () {
                              presenter.restorePurchase();
                            },
                            child:
                                const Text('Restaurar compra').body_regular()),

                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
              SizedBox(
                width: 8,
              ),
              Text("Voltar")
            ],
          ),
        ),
        Center(
          child: Container(
            height: 6,
            width: 45,
            decoration: const BoxDecoration(
                color: AppColor.textTertiaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
          ),
        ),
      ],
    );
  }
}

class _SubscriptionBenefitWidget extends StatelessWidget {
  const _SubscriptionBenefitWidget(
      {required this.assetPath,
      required this.serviceName,
      required this.serviceDescription});

  final String assetPath;
  final String serviceName;
  final String serviceDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          height: 48,
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(serviceName).body_bold(),
              const SizedBox(
                height: 4,
              ),
              Text(serviceDescription).caption1_regular(
                  style: const TextStyle(color: AppColor.textSecondaryColor)),
            ],
          ),
        )
      ],
    );
  }
}
