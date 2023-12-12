import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/drop_down/customer_drop_down_presenter.dart';
import 'package:driver_hub_partner/features/services/presenter/services_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDropDownController {
  Future<void> Function() load = () async {};
}

// ignore: must_be_immutable
class CustomerDropDownWidget extends StatelessWidget {
  CustomerDropDownWidget(
      {super.key, required this.onChanged, required this.controller}) {}

  Function(CustomerDto) onChanged;
  final CustomerDropDownController controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CustomerDropDownPresenter()..load(),
        child: Builder(builder: (context) {
          var presenter = context.read<CustomerDropDownPresenter>();
          controller.load = presenter.load;

          return BlocBuilder<CustomerDropDownPresenter, DHState>(
            builder: (context, state) => Builder(builder: (context) {
              return CustomDropdown<CustomerDto>.search(
                hintText: state is LoadingServicesDropdownState
                    ? 'Aguarde carregando...'
                    : 'Selecione o cliente',
                items: presenter.customersResponseDto.customers,
                searchHintText: "Buscar",
                excludeSelected: true,
                closedFillColor: AppColor.backgroundColor,
                closedBorder: Border.all(color: AppColor.borderColor),
                expandedFillColor: AppColor.backgroundColor,
                closedSuffixIcon: const Icon(Icons.arrow_drop_down_outlined,
                    color: AppColor.iconPrimaryColor),
                expandedBorder: Border.all(color: AppColor.borderColor),
                noResultFoundText:
                    "Nenhum serviço encontrado, entre em contato para adicionarmos o serviço desejado.",
                listItemBuilder: (context, item) =>
                    Text(item.name).body_regular(),
                noResultFoundBuilder: (context, text) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(child: Text(text).body_regular())),
                headerBuilder: (context, selectedItem) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Serviço').caption1_emphasized(
                          style: const TextStyle(
                              color: AppColor.textSecondaryColor)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(selectedItem.name).body_regular(
                          style:
                              const TextStyle(color: AppColor.textPrimaryColor))
                    ]),
                onChanged: (value) {
                  presenter.selectServiceDropDown(value);
                  onChanged(value);
                },
              );
            }),
          );
        }));
  }
}
