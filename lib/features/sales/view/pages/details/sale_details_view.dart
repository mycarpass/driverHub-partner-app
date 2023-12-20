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
          appBar: AppBar().backButton(),
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
                      const Text("Detalhes do cliente").label1_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      DetailsCellWidget(
                          items: ["Não informado"],
                          title: "Veículo do cliente"),
                      const DetailsCellWidget(
                          items: ["10/12/2022"], title: "Cliente desde"),
                      const SizedBox(
                        height: 24,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 12,
                      ),
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
