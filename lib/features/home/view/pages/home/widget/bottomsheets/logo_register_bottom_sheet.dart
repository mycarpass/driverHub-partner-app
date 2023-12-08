import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LogoRegisterBottomSheet extends StatelessWidget {
  const LogoRegisterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //var presenter = context.read<OnboardingPresenter>();
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                  child: const Text("Cadastrar sua Logomarca").label1_bold()),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Cadastre sua logo e uma foto de capa, isso irá chamar mais atenção dos clientes para o seu estabelecimento :)",
                textAlign: TextAlign.center,
              ).body_regular(),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  Image.asset(
                    'lib/assets/images/onboarding/HeaderPartner2.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 240,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: () {},
                          child: Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                  color:
                                      AppColor.backgroundColor.withOpacity(0.8),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: AppColor.accentColor)),
                              child: Center(
                                  child: const Text(
                                'Procurar capa \n(Opcional)',
                                textAlign: TextAlign.center,
                              ).label2_regular(
                                      style: const TextStyle(
                                          color:
                                              AppColor.textSecondaryColor))))),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                          transform: Matrix4.translationValues(6, -68, 0),
                          child: TextButton(
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.zero)),
                              onPressed: () {},
                              child: Container(
                                  // transform:
                                  //     Matrix4.translationValues(0, -60, 0),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: AppColor.backgroundColor
                                          .withOpacity(0.75),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          color: AppColor.accentHoverColor)),
                                  child: Center(
                                      child: const Text(
                                    'Procurar logo',
                                    textAlign: TextAlign.center,
                                  ).label2_regular(
                                          style: const TextStyle(
                                              color: AppColor
                                                  .textSecondaryColor)))))),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              BlocConsumer<OnboardingPresenter, DHState>(
                  listener: (context, state) {
                if (state is DHSuccessState) {
                  Navigator.of(context).pop(true);
                  DHSnackBar().showSnackBar(
                      "Parabéns!",
                      "Conta bancária cadastrada com sucesso",
                      DHSnackBarType.success);
                }
              }, builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is DHLoadingState
                        ? () {}
                        : () {
                            //  if(true) {
                            //   } else {
                            //     DHSnackBar().showSnackBar(
                            //         "Ops...",
                            //         "Preencha todos os dados corretamente antes de cadastrar.",
                            //         DHSnackBarType.error);
                            //   }
                          },
                    child: state is DHLoadingState
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColor.backgroundColor,
                            ),
                          )
                        : const Text("Cadastrar"),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
