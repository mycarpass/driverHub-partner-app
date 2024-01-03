// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:dh_ui_kit/view/widgets/tabs/dh_contained_tab_bar.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/header/tab_header.dart';
import 'package:driver_hub_partner/features/services/presenter/services_presenter.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/view/pages/home/services_list_widget.dart';
import 'package:driver_hub_partner/features/services/view/widgets/bottomsheets/service_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/services/view/widgets/loading/services_body_loading.dart';
import 'package:driver_hub_partner/features/services/view/widgets/services_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ServicesPresenter>(
          create: (BuildContext context) => ServicesPresenter()..load(),
        )
      ],
      child: Builder(
        builder: (context) {
          return DHPullToRefresh(
            onRefresh: context.read<ServicesPresenter>().load,
            key: UniqueKey(),
            child: BlocBuilder<ServicesPresenter, DHState>(
              builder: (context, state) {
                var presenter = context.read<ServicesPresenter>();
                return Stack(
                  children: [
                    if (state is DHLoadingState) ...[
                      const ServicesBodyLoading()
                    ] else if (state is DHErrorState) ...[
                      ServicesErrorWidget(
                        reload: presenter.load,
                      )
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 12, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabViewHeader(
                              onRefresh: () async {
                                presenter.load();
                              },
                              onPressed: () async {
                                bool? isServiceRegistered =
                                    await showModalBottomSheet<bool?>(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (_) => BlocProvider(
                                      create: (context) =>
                                          ServicesRegisterPresenter()..load(),
                                      child:
                                          ServiceRegisterBottomSheet.create()),
                                );

                                if (isServiceRegistered != null &&
                                    isServiceRegistered) {
                                  presenter.load();
                                }
                              },
                              title: "Serviços",
                              subtitle:
                                  "${presenter.partnerServicesResponseDto.partnerServicesLength()} cadastrados",
                            ),
                          ],
                        ),
                      ),

                      // Selecione o tipo do serviço
                      // Lavada / Serviços
                      // ------------------

                      // Nome do serviço (Obrigatorio)
                      // Descrição do serviço (Opcional)
                      // Preço por carroceria
                      // Switch Vísivel no App dos Clientes
                      // Tempo do serviço
                      // Dias de pós-vendas (Opcional)

                      DHContainedTabBar(
                        marginTop: 92,
                        tabTexts: const [
                          Text("Todos"),
                          Text("Visível para clientes"),
                        ],
                        views: [
                          ServicesListBodyWidget(
                            services:
                                presenter.partnerServicesResponseDto.services,
                            washes: presenter.partnerServicesResponseDto.washes,
                          ),
                          ServicesListBodyWidget(
                            services: presenter.partnerServicesResponseDto
                                .fetchServiceLiveOnApp(),
                            washes: presenter.partnerServicesResponseDto
                                .fetchWashesLiveOnApp(),
                          ),
                        ],
                      ),
                    ]
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
