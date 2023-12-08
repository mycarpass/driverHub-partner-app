import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/alerts/dh_alert_dialog.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/list/my_address_item_cell.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/fetch_address_response.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_state.dart';
import 'package:driver_hub_partner/features/sign_up/router/params/check_address_param.dart';
import 'package:driver_hub_partner/features/sign_up/router/sign_up_router.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/widgets/address_number_widget.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/widgets/address_options_widget.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/widgets/list_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddressSearchView extends StatefulWidget {
  AddressSearchView({super.key, this.onNewAddressSelected});
  Function()? onNewAddressSelected = () {};

  @override
  State<AddressSearchView> createState() => _AddressSearchViewState();
}

class _AddressSearchViewState extends State<AddressSearchView> {
  final _controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressPresenter>(
      create: (context) => AddressPresenter()..fetchAddress(),
      child: Builder(builder: (context) {
        var presenter = context.read<AddressPresenter>();
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Scaffold(
              appBar: AppBar().modalAppBar(
                title: 'Endereço',
                doneButtonIsEnabled: true,
                doneButtonText: "Fechar",
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 24.0),
                  child: BlocConsumer<AddressPresenter, DHState>(
                    listener: (context, state) async {
                      if (state is AddressAddedSuccessfulState) {
                        widget.onNewAddressSelected?.call();
                      }
                      if (state is AddressAvailableState) {
                        await Navigator.pushNamed(
                          context,
                          SignUpRoutes.checkAddress,
                          arguments: CheckAddressParams(
                            presenter,
                            state.address,
                          ),
                        );
                        DHSnackBar().showSnackBar(
                            "Sucesso!",
                            "Seu endereço foi adicionado com sucesso.",
                            DHSnackBarType.success);
                        await presenter.fetchAddress();
                        _controller.clear();
                      }
                      if (state is AddressOptionSuccessfulState) {
                        widget.onNewAddressSelected?.call();

                        DHSnackBar().showSnackBar(
                            "Sucesso!", state.message, DHSnackBarType.success);
                      } else if (state is AddressNotAvailableState) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          useSafeArea: true,
                          builder: (BuildContext _) {
                            return BlocProvider.value(
                              value: presenter,
                              child: DHAlertDialog(
                                description:
                                    "Infelizmente a sua região ainda não está disponível para os nossos serviços",
                                title: "Região não disponível",
                                primaryActionTitle:
                                    BlocConsumer<AddressPresenter, DHState>(
                                        listener: (context, state) async {
                                  if (state is DHErrorState) {
                                    DHSnackBar().showSnackBar(
                                        "Ops..",
                                        state.error ??
                                            "Ocorreu um erro, tente novamente mais tarde.",
                                        DHSnackBarType.error);
                                  }
                                }, builder: (context, state) {
                                  if (state is AddressInsertLoadingState) {
                                    return const DHCircularLoading();
                                  }
                                  return const Text("Adicionar mesmo assim");
                                }),
                                onPrimaryPressed: () async {
                                  Navigator.pop(context);
                                  await Navigator.pushNamed(
                                    context,
                                    SignUpRoutes.checkAddress,
                                    arguments: CheckAddressParams(
                                      presenter,
                                      state.address,
                                    ),
                                  );

                                  DHSnackBar().showSnackBar(
                                      "Sucesso!",
                                      "Seu endereço foi adicionado com sucesso.",
                                      DHSnackBarType.success);
                                  await presenter.fetchAddress();
                                  widget.onNewAddressSelected?.call();

                                  _controller.clear();
                                },
                                secondaryActionTitle: "Buscar outro endereço",
                                iconAssetPath:
                                    "lib/assets/images/LocationIconFilled.svg",
                                iconColor: AppColor.errorColor,
                              ),
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 120,
                                child: DHTextField(
                                  hint: "Buscar endereço",
                                  controller: _controller,
                                  icon: Icons.search,
                                  suffixIcon: Icons.clear,
                                  onClickSuffixIcon: () {
                                    _controller.clear();
                                    context
                                        .read<AddressPresenter>()
                                        .searchText = "";
                                    context.read<AddressPresenter>().clear();
                                  },
                                  onChanged: (query) async {
                                    context
                                        .read<AddressPresenter>()
                                        .isSearching(query);
                                    context
                                        .read<AddressPresenter>()
                                        .searchText = query;
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.read<AddressPresenter>().search(),
                                child: const Text("Buscar").label2_bold(
                                  style: TextStyle(
                                    color: state is AddressIsSearchingState &&
                                            state.isEnableToSearch
                                        ? AppColor.accentColor
                                        : AppColor.accentHoverColor
                                            .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          presenter.addressList.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: presenter.addressList.length,
                                    itemBuilder: (context, index) {
                                      final presenter =
                                          context.read<AddressPresenter>();
                                      List<GeoLocationResponseDto> listAddress =
                                          presenter.addressList;
                                      return BlocBuilder<AddressPresenter,
                                          DHState>(builder: (context, state) {
                                        return GestureDetector(
                                          onTap: state is DHLoadingState
                                              ? () {}
                                              : () async {
                                                  GeoLocationResponseDto
                                                      addressDto =
                                                      listAddress[index];
                                                  if (presenter
                                                      .isFilledHouseNumber(
                                                          addressDto.title)) {
                                                    presenter.verifyAddress(
                                                      addressDto,
                                                    );

                                                    // next step
                                                  } else {
                                                    // modal pra por numero
                                                    dynamic addressNumber =
                                                        await showModalBottomSheet<
                                                                String>(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return const AddressNumberWidget();
                                                            });

                                                    String addressFull = presenter
                                                        .concatenateAddressNumber(
                                                            addressDto.title,
                                                            addressNumber);

                                                    if (addressNumber ==
                                                        "S/N") {
                                                      addressDto.title =
                                                          addressFull;
                                                      await presenter
                                                          .verifyAddress(
                                                              addressDto);
                                                    } else {
                                                      presenter.searchText =
                                                          addressFull;
                                                      _controller.text =
                                                          addressFull;

                                                      presenter.search();
                                                    }
                                                  }
                                                },
                                          child: AddressListItemCell(
                                              title: listAddress[index].title,
                                              description: listAddress[index]
                                                  .description),
                                        );
                                      });
                                    },
                                  ),
                                )
                              : state is FetchAddressLoadingState
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      child: Center(
                                          child: DHCircularLoading(
                                        color: AppColor.accentColor,
                                      )))
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Text(
                                        presenter.myAdressesList.isNotEmpty
                                            ? 'Endereços salvos'
                                            : '',
                                        textAlign: TextAlign.left,
                                      ).caption1_emphasized(
                                          style: const TextStyle(
                                              color:
                                                  AppColor.textTertiaryColor))),
                          presenter.myAdressesList.isNotEmpty &&
                                  presenter.addressList.isEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 16,
                                          ),
                                      itemCount:
                                          presenter.myAdressesList.length,
                                      itemBuilder: (context, index) {
                                        List<FetchAddressReponseDto>
                                            myAdresses =
                                            presenter.myAdressesList;
                                        return GestureDetector(
                                          onTap: () async {
                                            // abrir bottom shet
                                            dynamic optionSelected =
                                                await showModalBottomSheet<
                                                        dynamic>(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddressOptionsWidget(
                                                        mainAddress:
                                                            myAdresses[index]
                                                                .mainAddress,
                                                      );
                                                    });

                                            await presenter.actionOption(
                                                optionSelected,
                                                myAdresses[index].id);
                                          },
                                          child: MyAdressItemCell(
                                              isHome: myAdresses[index].type ==
                                                  AddressType.home,
                                              isWork: myAdresses[index].type ==
                                                  AddressType.work,
                                              isSelected:
                                                  myAdresses[index].isSelected,
                                              title:
                                                  myAdresses[index].mainAddress,
                                              description: myAdresses[index]
                                                  .secondaryAddress),
                                        );
                                      }))
                              : Container()
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
