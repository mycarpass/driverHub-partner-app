import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/profile/presenter/profile_states.dart';
import 'package:driver_hub_partner/features/profile/presenter/profile_presenter.dart';
import 'package:driver_hub_partner/features/profile/view/widgets/bottomsheets/contact_info_sheet.dart';
import 'package:driver_hub_partner/features/profile/view/widgets/list_profile_card_row_widget.dart';
import 'package:driver_hub_partner/features/profile/view/widgets/params/profile_card_row_param.dart';
import 'package:driver_hub_partner/features/profile/view/widgets/profile_card_row_widget.dart';
import 'package:driver_hub_partner/features/welcome/router/welcome_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/alerts/dh_alert_dialog.dart';

class HomeProfileView extends StatefulWidget {
  const HomeProfileView({super.key});

  @override
  State<HomeProfileView> createState() => _HomeProfileViewState();
}

class _HomeProfileViewState extends State<HomeProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ProfilePresenter(),
      child: Builder(builder: (context) {
        final presenter = context.read<ProfilePresenter>();
        return Scaffold(
          body: BlocListener<ProfilePresenter, DHState>(
            listener: (context, state) => state is LogoutSuccessState
                ? Navigator.pushNamedAndRemoveUntil(
                    context, WelcomeRoutes.welcome, (route) => false)
                : DoNothingAction(),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Text('Conta').title1_bold()),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<HomePresenter, DHState>(
                        builder: (context, state) => state is DHErrorState ||
                                state is DHLoadingState
                            ? Container()
                            : ProfileCardRowWidget(
                                param: ProfileCardRowWidgetParam(
                                  backgroundColor:
                                      AppColor.backgroundTransparent,
                                  arrowColor: Colors.transparent,
                                  leading: presenter.getUrlLogo() != null
                                      ? SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(48)),
                                              child: Image.network(
                                                presenter.getUrlLogo()!,
                                                fit: BoxFit.cover,
                                              )))
                                      : CircleAvatar(
                                          backgroundColor:
                                              AppColor.backgroundTertiary,
                                          child: Text(
                                            presenter.getInitialsName(),
                                            overflow: TextOverflow.ellipsis,
                                          ).label1_bold(),
                                        ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        presenter.getName(),
                                        overflow: TextOverflow.ellipsis,
                                      ).label2_bold(),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(presenter.getEmail()).body_regular(
                                        style: const TextStyle(
                                            color: AppColor.textSecondaryColor),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              )),
                    const SizedBox(
                      height: 16,
                    ),
                    ListProfileCardRowWidget(param: [
                      ProfileCardRowWidgetParam(
                        leading: const Icon(
                          Icons.star,
                          color: AppColor.textTertiaryColor,
                        ),
                        title: Row(children: [
                          const Text("Avaliar o app").label2_bold(),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: 20,
                            decoration: const BoxDecoration(
                                color: AppColor.accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Center(
                              child: const Text(
                                "Novo",
                                textAlign: TextAlign.center,
                              ).caption1_bold(
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColor.backgroundColor),
                              ),
                            ),
                          ),
                        ]),
                        onPressed: () {
                          presenter.requestAppReview();
                        },
                      ),
                      ProfileCardRowWidgetParam(
                        leading: const Icon(
                          Icons.headphones,
                          color: AppColor.textTertiaryColor,
                        ),
                        title: const Text("Fale conosco").label2_bold(),
                        onPressed: () {
                          showModalBottomSheet<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return ContactInfoSheetWidget(
                                  onTapButton: () {
                                    Uri uri = Uri(
                                        host: "api.whatsapp.com",
                                        scheme: "https",
                                        path: "send",
                                        queryParameters: {
                                          "phone": "+5534984044391",
                                          "text":
                                              "[Fale conosco - DriverHub]: Gostaria de falar sobre..."
                                        });
                                    presenter.openUrl(uri);
                                  },
                                );
                              });
                        },
                      )
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    ListProfileCardRowWidget(
                      param: [
                        ProfileCardRowWidgetParam(
                          leading: const Icon(
                            Icons.privacy_tip_outlined,
                            color: AppColor.textTertiaryColor,
                          ),
                          title: const Text("Políticas de privacidade")
                              .label2_bold(),
                          onPressed: () {
                            Uri uri = Uri(
                              host: "driverhub.com.br",
                              scheme: "https",
                              path: "privacy-policy",
                            );
                            presenter.openUrl(uri);
                          },
                        ),
                        ProfileCardRowWidgetParam(
                          leading: const Icon(
                            Icons.document_scanner_outlined,
                            color: AppColor.textTertiaryColor,
                          ),
                          title: const Text("Termos de uso").label2_bold(),
                          onPressed: () {
                            Uri uri = Uri(
                              host: "driverhub.com.br",
                              scheme: "https",
                              path: "terms-of-service",
                            );
                            presenter.openUrl(uri);
                          },
                        ),
                        ProfileCardRowWidgetParam(
                            leading: const Icon(
                              Icons.logout_outlined,
                              color: AppColor.textTertiaryColor,
                            ),
                            title: const Text("Sair da conta").label2_bold(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  useSafeArea: true,
                                  builder: (BuildContext context) {
                                    return DHAlertDialog(
                                      description:
                                          "Espero que volte logo, \nvamos sentir a sua falta :(",
                                      title:
                                          "Tem certeza que gostaria de sair?",
                                      primaryActionTitle:
                                          const Text("Sair da conta"),
                                      onPrimaryPressed: () async {
                                        presenter.logout();
                                      },
                                      isHorizontalButtons: true,
                                      secondaryActionTitle: "Cancelar",
                                      iconAssetPath:
                                          "lib/assets/images/LogoutIcon.svg",
                                      iconColor: AppColor.supportColor,
                                    );
                                  });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ProfileCardRowWidget(
                      param: ProfileCardRowWidgetParam(
                        leading: const Icon(
                          Icons.delete_forever,
                          color: AppColor.errorColor,
                        ),
                        backgroundColor: AppColor.backgroundTransparent,
                        arrowColor: AppColor.errorColor,
                        title: const Text("Excluir conta").label2_bold(
                            style: const TextStyle(color: AppColor.errorColor)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              useSafeArea: true,
                              builder: (BuildContext context) {
                                return DHAlertDialog(
                                  description:
                                      "É uma ação irreverssível :(\nNos deixe tentar ajudar para que fique com a gente.",
                                  title:
                                      "Tem certeza que deseja apagar sua conta?",
                                  primaryActionTitle:
                                      const Text("Apagar conta"),
                                  onPrimaryPressed: () async {
                                    presenter.logout();
                                  },
                                  isHorizontalButtons: true,
                                  secondaryActionTitle: "Cancelar",
                                  iconAssetPath:
                                      "lib/assets/images/DeleteAccountIcon.svg",
                                  iconColor: AppColor.errorColor,
                                );
                              });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
