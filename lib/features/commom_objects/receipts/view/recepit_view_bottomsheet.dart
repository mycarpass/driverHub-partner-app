import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/button_style_extension.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/alerts/dh_alert_dialog.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/commom_objects/receipts/presenter/receipt_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ReceiptViewBottomSheet extends StatelessWidget {
  const ReceiptViewBottomSheet(
      {super.key,
      required this.receiptWdiget,
      this.customerPhone,
      this.whatsMessage});

  final Widget receiptWdiget;
  final PhoneValue? customerPhone;
  final String? whatsMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReceiptPresenter(),
        child: Builder(builder: (context) {
          var presenter = context.read<ReceiptPresenter>();
          return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.85,
              child: Scaffold(
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle().noStyle(),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                useSafeArea: true,
                                builder: (BuildContext context) {
                                  return DHAlertDialog(
                                    description:
                                        "O comprovante será salvo na sua galeria, após abrir a conversa com o cliente, anexe a imagem do comprovante juntamente com a mensagem, ok?",
                                    title: "Importante",
                                    primaryActionTitle: const Text("Entendi"),
                                    onPrimaryPressed: () async {
                                      Navigator.pop(context);
                                      await presenter.shareWhatsApp(
                                          customerPhone?.withoutSymbolValue ??
                                              "",
                                          whatsMessage ?? "");
                                    },
                                    isHorizontalButtons: true,
                                    secondaryActionTitle: "Cancelar",
                                    iconAssetPath:
                                        "lib/assets/images/LocationIconFilled.svg",
                                    iconColor: AppColor.warningColor,
                                  );
                                });
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 16,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                              "Enviar no WhatsApp do cliente")
                                          .body_regular(
                                              style: const TextStyle(
                                                  color:
                                                      AppColor.successColor)),
                                      const Icon(
                                        CustomIcons.dhWhatsapp,
                                        color: AppColor.successColor,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    height: 1,
                                    color: AppColor.borderColor,
                                  ),
                                ],
                              ))),
                      ElevatedButton(
                        style: const ButtonStyle().noStyle(),
                        onPressed: () async {
                          //Navigator.pop(context, AddressActionOption.workset);
                          await presenter.saveImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                            top: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Salvar arquivo").body_regular(
                                      style: const TextStyle(
                                          color: AppColor.textPrimaryColor)),
                                  const Icon(
                                    Icons.save_alt_outlined,
                                    color: AppColor.iconPrimaryColor,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 1,
                                color: AppColor.borderColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle().noStyle(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                            top: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Cancelar").body_regular(
                                      style: const TextStyle(
                                          color: AppColor.textSecondaryColor)),
                                  const Icon(
                                    Icons.close_rounded,
                                    color: AppColor.textSecondaryColor,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 48,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: BlocConsumer<ReceiptPresenter, DHState>(
                  listener: (context, state) {
                    if (state is DHErrorState) {
                      DHSnackBar().showSnackBar(
                          "Ops...",
                          "Ocorreu um erro ao gerar o comprovante, tente novamente mais tarde.",
                          DHSnackBarType.error);
                    } else if (state is ImageSavedSuccessful) {
                      DHSnackBar().showSnackBar(
                          "Sucesso!",
                          "Seu comprovante foi salvo com sucesso em sua galeria de fotos.",
                          DHSnackBarType.success);
                    }
                    if (state is ImageSharedSuccessful) {
                      DHSnackBar().showSnackBar(
                          "Sucesso!",
                          "Seu comprovante foi compartilhado com sucesso.",
                          DHSnackBarType.success);
                    }
                  },
                  builder: (context, state) => SingleChildScrollView(
                      child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.54,
                          margin: const EdgeInsets.only(
                              top: 4, left: 20, right: 20, bottom: 4),
                          decoration: const BoxDecoration(
                              color: AppColor.borderColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(children: [
                            Padding(
                                padding: const EdgeInsets.all(16),
                                child: WidgetsToImage(
                                    controller: presenter.controller,
                                    child: receiptWdiget))
                          ]))),
                ),
              ));
        }));
  }
}
