import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/details/service_details_presenter.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/view/widgets/bottomsheets/service_register_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ServicesDetailsView extends StatefulWidget {
  const ServicesDetailsView({
    super.key,
  });

  @override
  State<ServicesDetailsView> createState() => _ServicesDetailsViewState();
}

class _ServicesDetailsViewState extends State<ServicesDetailsView> {
  @override
  Widget build(BuildContext context) {
    PartnerServiceDto serviceDto =
        ModalRoute.of(context)?.settings.arguments as PartnerServiceDto;

    var presenter = context.read<ServiceDetailsPresenter>();
    presenter.load(serviceDto.serviceId.toString());
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar().modalAppBar(
              title: 'Serviço',
              showHeaderIcon: false,
              doneButtonIsEnabled: true,
              backButtonsIsVisible: true,
              onDonePressed: () async {
                bool? isServiceRegistered = await showModalBottomSheet<bool?>(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (_) => BlocProvider(
                    create: (context) => ServicesRegisterPresenter()..load(),
                    child: ServiceRegisterBottomSheet.update(serviceDto),
                  ),
                );
                if (isServiceRegistered != null) {
                  // ignore: use_build_context_synchronously
                  // Navigator.of(context).pop();
                  // presenter.load(serviceDto.serviceId.toString());
                }
              },
              doneButtonText: 'Editar'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                serviceDto.category == ServiceCategory.wash
                                    ? CustomIcons.dhCarWash
                                    : CustomIcons.dhCarService,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(serviceDto.name).label1_bold()
                            ],
                          ),
                          serviceDto.category == ServiceCategory.wash &&
                                  serviceDto.type == ServiceType.additional
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue[100],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: Row(children: [
                                    const Icon(
                                      CustomIcons.dhSun,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text('Adicional').caption2_bold()
                                  ]),
                                )
                              : const SizedBox.shrink(),
                        ]),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text('Descrição do serviço').caption1_regular(),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(serviceDto.description ?? 'Descrição não informada')
                        .body_regular(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Visível no App para Clientes?')
                        .caption1_regular(),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: serviceDto.isLiveOnApp ? 65 : 85,
                      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                      decoration: BoxDecoration(
                          color: serviceDto.isLiveOnApp
                              ? AppColor.supportColor
                              : AppColor.borderColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: Row(children: [
                        Icon(
                          serviceDto.isLiveOnApp
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(serviceDto.isLiveOnApp ? 'Visível' : 'Não visível')
                            .caption2_bold()
                      ]),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text('Tempo médio de execução').caption1_regular(),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(serviceDto.friendlyTime).body_regular(),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text('Dias de pós-vendas').caption1_regular(),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(serviceDto.daysPosSales != null
                            ? serviceDto.daysPosSales.toString()
                            : "Não informado")
                        .body_regular(),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<ServiceDetailsPresenter, DHState>(
                      builder: (context, state) {
                        if (state is DHLoadingState) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: DHSkeleton(
                                    child: Container(
                                      height: 80,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: DHSkeleton(
                                    child: Container(
                                      height: 560,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Dados sobre esse serviço')
                                  .label2_bold(),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text('Já foi vendido ').body_regular(),
                                  Text(presenter.serviceDetailsDto.soldAmount
                                          .toString())
                                      .body_bold(),
                                  const Text(' vezes').body_regular(),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text('Somando um total de ')
                                      .body_regular(),
                                  Text(presenter.serviceDetailsDto.totalBilled
                                          .priceInReal)
                                      .body_bold(),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text("Preços por carroceria").label1_bold(),
                              const SizedBox(
                                height: 8,
                              ),
                              ListView.separated(
                                itemCount:
                                    serviceDto.getOnlyDefaultPrices().length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                serviceDto
                                                    .getOnlyDefaultPrices()[
                                                        index]
                                                    .carBodyType
                                                    .icon,
                                                height: 30,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        AppColor.blackColor,
                                                        BlendMode.srcIn),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(serviceDto
                                                          .getOnlyDefaultPrices()[
                                                              index]
                                                          .carBodyType
                                                          .value)
                                                      .body_bold(),
                                                  // const SizedBox(
                                                  //   height: 4,
                                                  // ),
                                                  Text('${presenter.serviceDetailsDto.soldAmountPerCarBodyType.soldByType[serviceDto.getOnlyDefaultPrices()[index].carBodyType]?.toString() ?? "0"} venda(s)')
                                                      .body_regular()
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(serviceDto
                                              .getOnlyDefaultPrices()[index]
                                              .price
                                              .priceInReal)
                                          .body_bold()
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailsCellWidget extends StatelessWidget {
  const DetailsCellWidget(
      {super.key, required this.items, required this.title, this.iconButton});

  final List<String> items;
  final String title;
  final IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title).caption1_regular(
                style: const TextStyle(color: AppColor.textSecondaryColor)),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index]).label1_bold(),
                  index == 1 && iconButton != null
                      ? iconButton!
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
