import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/services_presenter.dart';
import 'package:driver_hub_partner/features/services/view/widgets/services_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesListBodyWidget extends StatefulWidget {
  const ServicesListBodyWidget(
      {required this.services, required this.washes, super.key});

  final List<PartnerServiceDto> services;
  final List<PartnerServiceDto> washes;

  @override
  State<ServicesListBodyWidget> createState() => _ServicesListBodyWidgetState();
}

class _ServicesListBodyWidgetState extends State<ServicesListBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            BlocBuilder<ServicesPresenter, DHState>(builder: (context, state) {
          return SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                widget.services.isEmpty
                    ? const Center(
                        child: EmptyStateList(
                        text: 'Nenhum serviço cadastrado \nainda por aqui :|',
                      ))
                    : Column(children: [
                        widget.washes.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 12),
                                itemCount: widget.washes.length,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Lavadas').label1_bold(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        ServiceItemWidget(
                                          serviceDto: widget.washes[index],
                                        )
                                      ],
                                    );
                                  }
                                  return ServiceItemWidget(
                                    serviceDto: widget.washes[index],
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                        widget.services.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 32),
                                itemCount: widget.services.length,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Serviços').label1_bold(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        ServiceItemWidget(
                                          serviceDto: widget.services[index],
                                        )
                                      ],
                                    );
                                  }
                                  return ServiceItemWidget(
                                    serviceDto: widget.services[index],
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ]),
              ]));
        }));
  }
}
