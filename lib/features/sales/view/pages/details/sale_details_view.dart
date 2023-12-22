import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:driver_hub_partner/features/customers/view/pages/detail/customer_details_view.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/presenter/detail/sale_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaleDetailsView extends StatefulWidget {
  const SaleDetailsView({
    super.key,
  });

  @override
  State<SaleDetailsView> createState() => _SaleDetailsViewState();
}

class _SaleDetailsViewState extends State<SaleDetailsView> {
  @override
  Widget build(BuildContext context) {
    SalesDto salesDto = ModalRoute.of(context)?.settings.arguments as SalesDto;

    var presenter = context.read<SaleDetailsPresenter>()..load();

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar().modalAppBar(
              title: "Venda",
              showHeaderIcon: false,
              doneButtonIsEnabled: false,
              doneButtonText: 'Editar'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Detalhes da venda").label1_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      DetailsCellWidget(
                          items: [salesDto.client.personName.name],
                          title: "Nome do cliente"),
                      DetailsCellWidget(
                          items: [salesDto.client.phone], title: "Telefone"),
                      DetailsCellWidget(
                          items: [salesDto.client.phone], title: "Veículo"),
                      const DetailsCellWidget(
                          items: ["10"], title: "Quantidade de vendas"),
                      const DetailsCellWidget(
                          items: ["R\$ 10,00"], title: "Total em vendas"),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
