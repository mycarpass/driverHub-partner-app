import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/presenter/customers_presenter.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/customer_item_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersListBodyWidget extends StatefulWidget {
  const CustomersListBodyWidget({required this.customers, super.key});

  final List<CustomerDto> customers;

  @override
  State<CustomersListBodyWidget> createState() =>
      _CustomersListBodyWidgetState();
}

class _CustomersListBodyWidgetState extends State<CustomersListBodyWidget> {
  @override
  Widget build(BuildContext context) {
    // var presenter = context.read<CustomersPresenter>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            BlocBuilder<CustomersPresenter, DHState>(builder: (context, state) {
          return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.customers.isEmpty
                    ? const Center(
                        child: EmptyStateList(
                        text: 'Nenhum cliente cadastrado.',
                      ))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 32),
                        itemCount: widget.customers.length,
                        itemBuilder: (context, index) {
                          return CustomerItemWidget(
                            customerDto: widget.customers[index],
                          );
                        },
                      ),
              ]);
        }));
  }
}
