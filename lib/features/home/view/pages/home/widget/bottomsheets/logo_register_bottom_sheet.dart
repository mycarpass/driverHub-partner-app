import 'dart:io';

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class LogoRegisterBottomSheet extends StatelessWidget {
  LogoRegisterBottomSheet({
    super.key,
  });

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var presenter = context.read<OnboardingPresenter>();
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: SingleChildScrollView(
          child: BlocListener<OnboardingPresenter, DHState>(
            listener: (context, state) {
              if (state is DHErrorState) {
                DHSnackBar().showSnackBar(
                    "Ops...",
                    "Ocorreu um erro ao tentar subir as imagens, tente novamente mais tarde.",
                    DHSnackBarType.error);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                      child:
                          const Text("Cadastrar sua Logomarca").label1_bold()),
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
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            'lib/assets/images/onboarding/HeaderPartner2.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 240,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.zero)),
                              onPressed: () async {
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  presenter.inputBackground(image);
                                }
                              },
                              child: BlocBuilder<OnboardingPresenter, DHState>(
                                  builder: (context, state) => Container(
                                      width: double.infinity,
                                      height: 180,
                                      decoration: BoxDecoration(
                                          color: AppColor.backgroundColor
                                              .withOpacity(0.8),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              color: AppColor.accentColor)),
                                      child: presenter.logoAccountDto
                                                  .imageBackgroundFile !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.file(
                                                File(presenter.logoAccountDto
                                                    .imageBackgroundFile!.path),
                                                fit: BoxFit.cover,
                                              ))
                                          : Center(
                                              child: const Text(
                                              'Procurar capa \n(Opcional)',
                                              textAlign: TextAlign.center,
                                            ).label2_regular(
                                                  style: const TextStyle(
                                                      color: AppColor
                                                          .textSecondaryColor)))))),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                              transform: Matrix4.translationValues(6, -68, 0),
                              child: TextButton(
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                  onPressed: () async {
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      presenter.inputLogo(image);
                                    }
                                  },
                                  child: BlocBuilder<OnboardingPresenter,
                                          DHState>(
                                      builder: (context, state) => Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: AppColor.backgroundColor
                                                  .withOpacity(0.75),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16)),
                                              border: Border.all(
                                                  style: BorderStyle.solid,
                                                  color: AppColor
                                                      .accentHoverColor)),
                                          child: presenter.logoAccountDto
                                                      .imageLogoFile !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  child: Image.file(
                                                    File(presenter
                                                        .logoAccountDto
                                                        .imageLogoFile!
                                                        .path),
                                                    fit: BoxFit.cover,
                                                  ))
                                              : Center(
                                                  child: const Text(
                                                  'Procurar logo',
                                                  textAlign: TextAlign.center,
                                                ).label2_regular(style: const TextStyle(color: AppColor.textSecondaryColor))))))),
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
                          "Logomarca cadastrada com sucesso",
                          DHSnackBarType.success);
                    }
                  }, builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is DHLoadingState
                            ? () {}
                            : () async {
                                if (presenter.logoAccountDto.imageLogoFile !=
                                    null) {
                                  await presenter.sendImageLogo();
                                } else {
                                  DHSnackBar().showSnackBar(
                                      "Ops...",
                                      "Carregue sua logomarca para continuar.",
                                      DHSnackBarType.error);
                                }
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
        ));
  }
}
