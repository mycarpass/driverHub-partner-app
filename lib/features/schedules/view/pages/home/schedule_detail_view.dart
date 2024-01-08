// ignore_for_file: prefer_const_constructors

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/button_style_extension.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/commom_objects/receipts/view/recepit_view_bottomsheet.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/customers/router/customers_router.dart';
import 'package:driver_hub_partner/features/customers/router/params/customer_detail_param.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedule_detail_presenter.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedule_detail_state.dart';
import 'package:driver_hub_partner/features/schedules/router/params/schedule_detail_param.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/add_checklist_photo_bottomsheet.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/receipt/receipt_schedule.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/loading/schedules_body_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';

class ScheduleDetailView extends StatelessWidget {
  const ScheduleDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScheduleDetailParams scheduleDetailParams =
        ModalRoute.of(context)!.settings.arguments as ScheduleDetailParams;
    return BlocProvider<ScheduleDetailPresenter>(
      create: (context) =>
          ScheduleDetailPresenter(scheduleId: scheduleDetailParams.scheduleId)
            ..load(),
      child: Builder(
        builder: (builderContext) {
          var presenter = builderContext.read<ScheduleDetailPresenter>();
          return Scaffold(
            appBar: AppBar().backButton(onPressed: () {
              Navigator.pop(context, false);
            }),
            body: BlocConsumer<ScheduleDetailPresenter, DHState>(
                listener: (context, state) {
              if (state is ScheduleAcceptedSuccess) {
                DHSnackBar().showSnackBar(
                    "Sucesso!",
                    "Agendamento foi aceito com sucesso!",
                    DHSnackBarType.success);
                // Navigator.pop(context, true);
              } else if (state is ScheduleStartedSuccess) {
                DHSnackBar().showSnackBar(
                    "Sucesso!",
                    "Agendamento foi iniciado com sucesso!",
                    DHSnackBarType.success);
                // Navigator.pop(context, true);
              } else if (state is ScheduleFinishedSuccess) {
                DHSnackBar().showSnackBar(
                    "Sucesso!",
                    "Agendamento foi finalizado com sucesso!",
                    DHSnackBarType.success);
                // Navigator.pop(context, true);
              } else if (state is ScheduleSuggestedSuccess) {
                DHSnackBar().showSnackBar(
                    "Sucesso!",
                    "Uma sugestão de um novo horário foi enviado com sucesso!",
                    DHSnackBarType.success);
                //  Navigator.pop(context, true);
              } else if (state is ScheduleDeletedSuccess) {
                Navigator.pop(context);
                DHSnackBar().showSnackBar(
                    "Sucesso!",
                    "Seu agendamento foi excluído com sucesso!",
                    DHSnackBarType.success);
              } else if (state is DHErrorState) {
                DHSnackBar().showSnackBar(
                    "Ops!",
                    "Um erro inesperado aconteceu, tente novamente mais tarde.",
                    DHSnackBarType.error);
              }
            }, builder: (context, state) {
              return state is ScheduleLoadingBody
                  ? SchedulesBodyLoading()
                  : SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: presenter.scheduleDataDto
                                                  .fetchTagColor(),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24))),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              presenter.scheduleDataDto
                                                  .statusFriendly,
                                              overflow: TextOverflow.ellipsis,
                                            ).label1_bold(
                                                style: TextStyle(fontSize: 15)),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text('Criado em ${presenter.scheduleDataDto.scheduleDate}')
                                                .caption1_regular(
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .textSecondaryColor))
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(children: [
                                      Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
                                          decoration: BoxDecoration(
                                              color: AppColor.backgroundColor,
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: AppColor.accentColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8))),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(presenter.scheduleDataDto
                                                            .delivery
                                                        ? "À domicílio"
                                                        : "Cliente irá levar")
                                                    .caption2_regular()
                                              ]))
                                    ])
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppColor.supportColor,
                                              child: Text(PersonName(presenter
                                                          .scheduleDataDto
                                                          .client
                                                          .name)
                                                      .getInitialsName())
                                                  .label2_regular(),
                                            )),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(presenter.scheduleDataDto
                                                    .client.name)
                                                .body_bold(),
                                            Text(presenter.scheduleDataDto
                                                    .client.phone)
                                                .body_regular(),
                                          ],
                                        )
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            CustomerRoutes.detail,
                                            arguments: CustomerDetailParams(
                                              customerDto: CustomerDto(
                                                  vehicle: presenter
                                                      .scheduleDataDto.vehicle,
                                                  customerId: presenter
                                                      .scheduleDataDto
                                                      .client
                                                      .id,
                                                  phone: PhoneValue(
                                                      value: presenter
                                                          .scheduleDataDto
                                                          .client
                                                          .phone),
                                                  status:
                                                      CustomerStatus.verified,
                                                  isSubscribed: false,
                                                  name: PersonName(presenter
                                                      .scheduleDataDto
                                                      .client
                                                      .name)),
                                            ),
                                          );
                                        },
                                        child: Row(children: [
                                          const Text('Ver cliente')
                                              .caption1_regular(
                                                  style: const TextStyle(
                                                      color: AppColor
                                                          .textSecondaryColor)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          const Icon(Icons.open_in_new,
                                              color: AppColor.iconPrimaryColor,
                                              size: 16),
                                        ]))
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Text('Veículo do cliente')
                                    .caption1_regular(),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(children: [
                                  Text(presenter
                                              .scheduleDataDto.vehicle?.make ??
                                          "Não informado")
                                      .body_regular(),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(presenter.scheduleDataDto.vehicle
                                              ?.nickname ??
                                          "")
                                      .body_regular()
                                ]),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text('Data do agendamento')
                                    .caption1_regular(),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(presenter.scheduleDataDto.scheduleDate)
                                    .body_bold(),
                                SizedBox(
                                  height: 8,
                                ),
                                presenter.scheduleDataDto.canShowSelectedHour()
                                    ? TextButton(
                                        style: ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            )),
                                            padding: MaterialStatePropertyAll(
                                                EdgeInsets.only(bottom: 8))),
                                        onPressed: null,
                                        child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 4, 8, 4),
                                            decoration: BoxDecoration(
                                                color: AppColor.accentColor
                                                    .withOpacity(0.45),
                                                border: Border.all(
                                                    color:
                                                        AppColor.accentColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Text(
                                              presenter.scheduleDataDto
                                                  .getSelectecHour(),
                                              textAlign: TextAlign.center,
                                            ).label2_regular()))
                                    : presenter.scheduleDataDto.waitingClient()
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 12),
                                            child: Text(
                                                    'Aguardando cliente escolher novo horário')
                                                .body_regular())
                                        : SizedBox(
                                            height: 48,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: presenter
                                                  .scheduleDataDto
                                                  .getTimeSuggestions()
                                                  .length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 12,
                                              ),
                                              itemBuilder: (context, index) {
                                                var timeSuggestions = presenter
                                                    .scheduleDataDto
                                                    .getTimeSuggestions();
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextButton(
                                                          style: ButtonStyle(
                                                              tapTargetSize:
                                                                  MaterialTapTargetSize
                                                                      .shrinkWrap,
                                                              shape: MaterialStateProperty.all(
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              )),
                                                              padding: MaterialStatePropertyAll(
                                                                  EdgeInsets
                                                                      .zero)),
                                                          onPressed: () {
                                                            presenter
                                                                .selectTimeSuggestion(
                                                                    timeSuggestions[
                                                                        index]);
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets.fromLTRB(
                                                                  8, 4, 8, 4),
                                                              decoration: BoxDecoration(
                                                                  color: presenter.timeSuggestionSelected.id == timeSuggestions[index].id
                                                                      ? AppColor.accentColor.withOpacity(
                                                                          0.45)
                                                                      : AppColor
                                                                          .backgroundTransparent,
                                                                  border: Border.all(
                                                                      color: presenter.timeSuggestionSelected.id == timeSuggestions[index].id
                                                                          ? AppColor.accentColor
                                                                          : AppColor.textTertiaryColor),
                                                                  borderRadius: BorderRadius.all(Radius.circular(8))),
                                                              child: Text(
                                                                timeSuggestions[
                                                                        index]
                                                                    .time,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ).label2_regular())),
                                                    ]);
                                              },
                                            )),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text('Cliente').caption1_regular(
                                //         style: TextStyle(
                                //             color:
                                //                 AppColor.textSecondaryColor)),
                                //     SizedBox(
                                //       height: 8,
                                //     ),
                                //     Text(presenter.scheduleDataDto.client.name)
                                //         .label1_bold(),
                                //     SizedBox(
                                //       height: 8,
                                //     ),
                                // presenter.scheduleDataDto
                                //         .canTalkWithClient()
                                //     ? Row(
                                //         children: [
                                //           Text('Precisa falar com o cliente?')
                                //               .caption1_regular(
                                //                   style: TextStyle(
                                //                       color: AppColor
                                //                           .textSecondaryColor)),
                                //           TextButton(
                                //               style: ButtonStyle(
                                //                   tapTargetSize:
                                //                       MaterialTapTargetSize
                                //                           .shrinkWrap,
                                //                   shape: MaterialStateProperty
                                //                       .all(
                                //                           RoundedRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius
                                //                             .circular(8),
                                //                   )),
                                //                   elevation:
                                //                       MaterialStatePropertyAll(
                                //                           0),
                                //                   padding:
                                //                       MaterialStatePropertyAll(
                                //                           EdgeInsets.only(
                                //                               left: 4))),
                                //               onPressed: () async {
                                //                 Uri uri = Uri(
                                //                   host: "wa.me",
                                //                   scheme: "https",
                                //                   path:
                                //                       "55${presenter.scheduleDataDto.client.phone.replaceAll("(", "").replaceAll(")", "").replaceAll(" ", "").replaceAll("-", "")}",
                                //                 );
                                //                 if (!await launchUrl(
                                //                   uri,
                                //                   mode: LaunchMode
                                //                       .externalApplication,
                                //                 )) {
                                //                   throw Exception(
                                //                       'Could not launch $uri');
                                //                 }
                                //               },
                                //               child: Text('Clique aqui')
                                //                   .body_regular())
                                //         ],
                                //       )
                                //     : SizedBox(
                                //         height: 8,
                                //       ),
                                //   ],
                                // ),
                                // Divider(),
                                // SizedBox(
                                //   height: 12,
                                // ),

                                SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Serviços escolhidos')
                                        .caption1_regular(
                                            style: TextStyle(
                                                color: AppColor
                                                    .textSecondaryColor)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: presenter.scheduleDataDto
                                          .selectedServices.items.length,
                                      itemBuilder: (context, index) {
                                        String includesString = '';
                                        List<dynamic> listIncluded = presenter
                                            .scheduleDataDto
                                            .selectedServices
                                            .items[index]
                                            .includedServices;

                                        if (listIncluded.isNotEmpty) {
                                          includesString = "Adicionais: ";
                                          for (var includedService
                                              in listIncluded) {
                                            if (includedService ==
                                                listIncluded.last) {
                                              includesString += includedService;
                                            } else {
                                              includesString +=
                                                  includedService + ", ";
                                            }
                                          }
                                        }
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${presenter.scheduleDataDto.selectedServices.items[index].service} ")
                                                  .body_bold(),
                                              includesString != ""
                                                  ? Text(includesString)
                                                      .body_regular()
                                                  : SizedBox.shrink()
                                            ]);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                presenter.scheduleDataDto.photoList.isNotEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Checklist de fotos').body_bold(
                                              style: TextStyle(
                                                  color: AppColor
                                                      .textPrimaryColor)),
                                          Text('As fotos são compartilhadas no app do cliente')
                                              .caption1_regular(
                                                  style: TextStyle(
                                                      color: AppColor
                                                          .textSecondaryColor)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          BlocBuilder<ScheduleDetailPresenter,
                                                  DHState>(
                                              builder: (context, state) {
                                            return SizedBox(
                                              height: 120,
                                              child: ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: presenter
                                                    .scheduleDataDto
                                                    .photoList
                                                    .length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                  width: 8,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Stack(
                                                    children: [
                                                      presenter
                                                              .scheduleDataDto
                                                              .photoList[index]
                                                              .networkPath
                                                              .isEmpty
                                                          ? SizedBox(
                                                              width: 120,
                                                              height: 160,
                                                              child:
                                                                  Image.asset(
                                                                presenter
                                                                    .scheduleDataDto
                                                                    .photoList[
                                                                        index]
                                                                    .file
                                                                    .path,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ))
                                                          : SizedBox(
                                                              width: 120,
                                                              height: 160,
                                                              child:
                                                                  Image.network(
                                                                presenter
                                                                    .scheduleDataDto
                                                                    .photoList[
                                                                        index]
                                                                    .networkPath,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                      Positioned(
                                                        right: 0,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                12,
                                                              ),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                12,
                                                              ),
                                                            ),
                                                            color: AppColor
                                                                .errorColor,
                                                          ),
                                                          child: SizedBox(
                                                            height: 44,
                                                            width: 44,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                presenter
                                                                    .removePhoto(
                                                                  presenter
                                                                      .scheduleDataDto
                                                                      .photoList[index],
                                                                );
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                padding: MaterialStatePropertyAll(
                                                                    EdgeInsets
                                                                        .zero),
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  AppColor
                                                                      .errorColor,
                                                                ),
                                                              ),
                                                              child: state
                                                                          is SchedulePhotoRemoveLoading &&
                                                                      state.id ==
                                                                          presenter
                                                                              .scheduleDataDto
                                                                              .photoList[
                                                                                  index]
                                                                              .id
                                                                  ? DHCircularLoading()
                                                                  : SizedBox(
                                                                      height:
                                                                          44,
                                                                      width: 44,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .delete_forever_outlined,
                                                                        size:
                                                                            24,
                                                                      )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ],
                                      )
                                    : SizedBox.shrink(),

                                Divider(
                                  height: 48,
                                ),
                                Text('Ações do agendamento').label2_bold(),
                                SizedBox(
                                  height: 8,
                                ),
                                !presenter.scheduleDataDto.isNotShowAction()
                                    ? ElevatedButton(
                                        style: const ButtonStyle().noStyle(),
                                        onPressed: () {
                                          //Navigator.pop(context, AddressActionOption.workset);
                                          presenter.action(context);
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(presenter.scheduleDataDto
                                                          .actionText())
                                                      .body_bold(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .textPrimaryColor)),
                                                  BlocBuilder<
                                                      ScheduleDetailPresenter,
                                                      DHState>(
                                                    builder: (context, state) {
                                                      if (state
                                                          is ScheduleLoadingButton) {
                                                        return const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: AppColor
                                                                .accentColor,
                                                          ),
                                                        );
                                                      }
                                                      return const Icon(
                                                        Icons
                                                            .play_circle_outline_outlined,
                                                        color: AppColor
                                                            .accentColor,
                                                      );
                                                    },
                                                  ),
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
                                      )
                                    : const SizedBox.shrink(),
                                !presenter.scheduleDataDto.isNotShowAction() &&
                                        presenter.scheduleDataDto
                                            .serviceIsNotAccepted()
                                    ? ElevatedButton(
                                        style: const ButtonStyle().noStyle(),
                                        onPressed: () {
                                          //Navigator.pop(context, AddressActionOption.workset);
                                          presenter.openSuggestNewDate(context);
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                          "Sugerir novos horários")
                                                      .body_regular(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .textPrimaryColor)),
                                                  const Icon(
                                                    Icons.timer_outlined,
                                                    color:
                                                        AppColor.warningColor,
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
                                      )
                                    : const SizedBox.shrink(),
                                presenter.scheduleDataDto.canTalkWithClient()
                                    ? ElevatedButton(
                                        style: const ButtonStyle().noStyle(),
                                        onPressed: () {
                                          PhoneValue phoneValue = PhoneValue(
                                              value: presenter.scheduleDataDto
                                                  .client.phone);

                                          FlutterShareMe()
                                              .shareWhatsAppPersonalMessage(
                                                  message: "",
                                                  phoneNumber:
                                                      "55${phoneValue.withoutSymbolValue}");
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                          "Falar com o cliente")
                                                      .body_regular(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .textPrimaryColor)),
                                                  const Icon(
                                                    CustomIcons.dhWhatsapp,
                                                    color:
                                                        AppColor.successColor,
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
                                      )
                                    : const SizedBox.shrink(),
                                false

                                    ///TODO uncoment
                                    ?
                                    //  presenter.scheduleDataDto.isPhotoCheckListFull() ?
                                    SizedBox.shrink()
                                    : ElevatedButton(
                                        style: const ButtonStyle().noStyle(),
                                        onPressed: () async {
                                          Map<String, dynamic>? response =
                                              await showModalBottomSheet(
                                            showDragHandle: true,
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return AddChecklisPhotoBottomSheet(
                                                id: presenter.scheduleId,
                                              );
                                            },
                                          );

                                          if (response != null) {
                                            presenter.addPhotoToCheckList(
                                                response["photo"],
                                                response["description"],
                                                response["photoId"]);
                                          }
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                          "Adicionar foto ao checklist")
                                                      .body_regular(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .textPrimaryColor)),
                                                  const Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: AppColor
                                                        .iconPrimaryColor,
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
                                    //Navigator.pop(context, AddressActionOption.workset);
                                    showModalBottomSheet(
                                        context: context,
                                        showDragHandle: true,
                                        isScrollControlled: true,
                                        builder: (context) =>
                                            ReceiptViewBottomSheet(
                                                customerPhone: PhoneValue(
                                                    value: presenter
                                                        .scheduleDataDto
                                                        .client
                                                        .phone),
                                                whatsMessage:
                                                    'Olá ${presenter.scheduleDataDto.client.name}, aqui está o comprovante do seu agendamento com ${presenter.scheduleDataDto.partner?.name ?? ""}',
                                                receiptWdiget: ScheduleReceipt(
                                                  entity: presenter
                                                      .getScheduleReceiptEntity(),
                                                )));
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
                                            const Text("Gerar comprovante")
                                                .body_regular(
                                                    style: const TextStyle(
                                                        color: AppColor
                                                            .textPrimaryColor)),
                                            const Icon(
                                              Icons.receipt_long_rounded,
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

                                (presenter.scheduleDataDto.paymentType ==
                                                null ||
                                            presenter.scheduleDataDto
                                                    .paymentType ==
                                                "") &&
                                        presenter.scheduleDataDto
                                            .canTalkWithClient()
                                    ? ElevatedButton(
                                        style: const ButtonStyle().noStyle(),
                                        onPressed: () {
                                          presenter.deleteSchedule(context);
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                          "Excluir agendamento")
                                                      .body_regular(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .errorColor)),
                                                  const Icon(
                                                    Icons.delete_outline,
                                                    color: AppColor.errorColor,
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
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(
                                  height: 12,
                                ),
                              ])));
            }),
            // bottomNavigationBar: BlocBuilder<ScheduleDetailPresenter, DHState>(
            //   builder: (context, state) {
            //     return state is ScheduleLoadingBody
            //         ? SizedBox.shrink()
            //         : !presenter.scheduleDataDto.isNotShowAction()
            //             ? Padding(
            //                 padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 8.0, vertical: 16),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           // presenter.scheduleDataDto
            //                           //         .serviceIsNotAccepted()
            //                           //     ? Column(
            //                           //         mainAxisAlignment:
            //                           //             MainAxisAlignment.start,
            //                           //         crossAxisAlignment:
            //                           //             CrossAxisAlignment.start,
            //                           //         children: [
            //                           //           const Text(
            //                           //                   "Não consegue no horário?")
            //                           //               .caption1_bold(
            //                           //                   style: const TextStyle(
            //                           //                       color: AppColor
            //                           //                           .textSecondaryColor)),
            //                           //           TextButton(
            //                           //               style: ButtonStyle(
            //                           //                   tapTargetSize:
            //                           //                       MaterialTapTargetSize
            //                           //                           .shrinkWrap,
            //                           //                   padding:
            //                           //                       MaterialStatePropertyAll(
            //                           //                           EdgeInsets
            //                           //                               .zero),
            //                           //                   elevation:
            //                           //                       MaterialStatePropertyAll(
            //                           //                           0)),
            //                           //               onPressed: () {
            //                           //                 presenter
            //                           //                     .openSuggestNewDate(
            //                           //                         context);
            //                           //               },
            //                           //               child: Text(
            //                           //                 "Sugerir novos horários",
            //                           //                 textAlign: TextAlign.left,
            //                           //               ).caption1_bold(
            //                           //                   style: TextStyle(
            //                           //                       color: AppColor
            //                           //                           .warningColor)))
            //                           //         ],
            //                           //       )
            //                           //     : presenter.scheduleDataDto
            //                           //                     .paymentType ==
            //                           //                 null ||
            //                           //             presenter.scheduleDataDto
            //                           //                     .paymentType ==
            //                           //                 ""
            //                           //         ? TextButton(
            //                           //             style: ButtonStyle(
            //                           //                 tapTargetSize:
            //                           //                     MaterialTapTargetSize
            //                           //                         .shrinkWrap,
            //                           //                 padding:
            //                           //                     MaterialStatePropertyAll(
            //                           //                         EdgeInsets.zero),
            //                           //                 elevation:
            //                           //                     MaterialStatePropertyAll(
            //                           //                         0)),
            //                           //             onPressed: () {
            //                           //               presenter.deleteSchedule(
            //                           //                   context);
            //                           //             },
            //                           //             child: Row(
            //                           //               children: [
            //                           //                 Icon(
            //                           //                   Icons
            //                           //                       .delete_outline_outlined,
            //                           //                   color:
            //                           //                       AppColor.errorColor,
            //                           //                 ),
            //                           //                 SizedBox(
            //                           //                   width: 8,
            //                           //                 ),
            //                           //                 Text(
            //                           //                   "Excluir",
            //                           //                   textAlign:
            //                           //                       TextAlign.left,
            //                           //                 ).body_bold(
            //                           //                     style: TextStyle(
            //                           //                         color: AppColor
            //                           //                             .errorColor))
            //                           //               ],
            //                           //             ))
            //                           //         : SizedBox.shrink(),
            //                           ElevatedButton(
            //                             onPressed:
            //                                 state is ScheduleLoadingButton
            //                                     ? null
            //                                     : () {
            //                                         presenter.action(context);
            //                                       },
            //                             child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.center,
            //                               children: [
            //                                 BlocBuilder<ScheduleDetailPresenter,
            //                                     DHState>(
            //                                   builder: (context, state) {
            //                                     if (state
            //                                         is ScheduleLoadingButton) {
            //                                       return const SizedBox(
            //                                         height: 20,
            //                                         width: 20,
            //                                         child:
            //                                             CircularProgressIndicator(
            //                                           color: AppColor
            //                                               .backgroundColor,
            //                                         ),
            //                                       );
            //                                     }
            //                                     return Text(
            //                                       presenter.scheduleDataDto
            //                                           .actionText(),
            //                                     );
            //                                   },
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             : SizedBox.shrink();
            //   },
            // ),
          );
        },
      ),
    );
  }
}
