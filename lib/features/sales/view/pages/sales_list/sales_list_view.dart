import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:driver_hub_partner/features/commom_objects/extensions/date_extensions.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/sales_list_item_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SalesListView extends StatefulWidget {
  const SalesListView({super.key});

  @override
  State<SalesListView> createState() => _SalesListViewState();
}

class _SalesListViewState extends State<SalesListView> {
  List<SalesDto> sales = [];
  late DateTime daySelected;
  @override
  void didChangeDependencies() {
    dynamic args = ModalRoute.of(context)?.settings.arguments;
    sales = args['sales'] ?? [];
    daySelected = args['day'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var presenter = context.read<SchedulesPresenter>();
    return Scaffold(
      appBar: AppBar().backButton(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(daySelected.formatDate('dd, EEEE', 'pt_BR')).title2_bold(),
              const SizedBox(
                height: 24,
              ),
              sales.isEmpty
                  ? const EmptyStateList(
                      text: 'Nenhuma venda encontrado para a data selecionada.',
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 32),
                      itemCount: sales.length,
                      itemBuilder: (context, index) {
                        return SalesListItemWidget(
                          solicitationDataDto: sales[index],
                        );
                      },
                    ),
            ],
          )),
    );
  }
}
