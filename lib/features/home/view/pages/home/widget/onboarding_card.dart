import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/bottomsheets/bank_account_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/bottomsheets/logo_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/view/widgets/bottomsheets/service_register_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCardWidget extends StatelessWidget {
  const OnboardingCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<OnboardingPresenter>();
    return Card(
      color: AppColor.backgroundTransparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(
                Icons.settings,
                color: AppColor.iconSecondaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Primeiros passos").body_bold(),
              const Expanded(child: SizedBox.shrink()),
            ]),
            const SizedBox(
              height: 4,
            ),
            const Text(
                    "Complete seus dados e fique visível para os clientes no app da DriverHub")
                .body_regular(),
            const SizedBox(
              height: 8,
            ),
            !presenter.isBankAccountOnboardingCompleted()
                ? Row(children: [
                    const Icon(
                      Icons.warning,
                      size: 20,
                      color: AppColor.warningColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Conta bancária").body_regular(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(8))),
                        onPressed: () async {
                          bool? isBankAccountRegistered =
                              await showModalBottomSheet<bool?>(
                            context: context,
                            showDragHandle: true,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider.value(
                                value: presenter,
                                child: BankAccountRegisterBottomSheet(
                                  accountCNPJ: context
                                      .read<HomePresenter>()
                                      .homeResponseDto
                                      .data
                                      .partnerData
                                      .cnpj,
                                )),
                          );
                          if (isBankAccountRegistered != null &&
                              isBankAccountRegistered) {
                            // ignore: use_build_context_synchronously
                            context.read<HomePresenter>().load();
                          }
                        },
                        child: const Text("Cadastrar").body_bold(
                            style:
                                const TextStyle(color: AppColor.accentColor)))
                  ])
                : const SizedBox.shrink(),

            !presenter.isLogoOnboardingCompleted()
                ? Row(children: [
                    const Icon(
                      Icons.warning,
                      size: 20,
                      color: AppColor.warningColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Logomarca").body_regular(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(8))),
                        onPressed: () async {
                          bool? isLogoRegistered =
                              await showModalBottomSheet<bool?>(
                            context: context,
                            showDragHandle: true,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider.value(
                                value: presenter,
                                child: LogoRegisterBottomSheet()),
                          );
                          if (isLogoRegistered != null && isLogoRegistered) {
                            // ignore: use_build_context_synchronously
                            context.read<HomePresenter>().load();
                          }
                        },
                        child: const Text("Cadastrar").body_bold(
                            style:
                                const TextStyle(color: AppColor.accentColor)))
                  ])
                : const SizedBox.shrink(),

            !presenter.isServiceOnboardingCompleted()
                ? Row(children: [
                    const Icon(
                      Icons.warning,
                      size: 20,
                      color: AppColor.warningColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Serviços").body_regular(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(8))),
                        onPressed: () async {
                          bool? isServiceRegistered =
                              await showModalBottomSheet<bool?>(
                            context: context,
                            showDragHandle: true,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider(
                                create: (context) =>
                                    ServicesRegisterPresenter()..load(),
                                child: ServiceRegisterBottomSheet()),
                          );
                          if (isServiceRegistered != null &&
                              isServiceRegistered) {
                            // ignore: use_build_context_synchronously
                            context.read<HomePresenter>().load();
                          }
                        },
                        child: const Text("Cadastrar").body_bold(
                            style:
                                const TextStyle(color: AppColor.accentColor)))
                  ])
                : const SizedBox.shrink(),

            // Row(
            //   children: [
            //     const Text("Total de assinantes").body_regular(),
            //     const Expanded(child: SizedBox.shrink()),
            //   ],
            // ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     !presenter.isVisible
            //         ? Container(
            //             margin: const EdgeInsets.only(top: 4),
            //             decoration: const BoxDecoration(
            //                 color: AppColor.iconPrimaryColor,
            //                 borderRadius: BorderRadius.all(Radius.circular(8))),
            //             height: 24,
            //             width: 60,
            //           )
            //         : Text(
            //             presenter.financialInfoDto.data.accountInfo
            //                 .totalActiveSubscriptions
            //                 .toString(),
            //           ).title2_bold(),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
