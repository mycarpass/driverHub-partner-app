import 'package:driver_hub_partner/features/pos_sales/presenter/detail/pos_sale_detail_presenter.dart';
import 'package:driver_hub_partner/features/pos_sales/view/pages/details/pos_sale_details_view.dart';
import 'package:driver_hub_partner/features/pos_sales/view/pages/sales_list/pos_sales_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PosSalesRoutes {
  static const posSalesDetail = "/pos-sales-detail";
  static const posSalesList = "/pos-sales-list";
}

abstract class PosSalesRoutesMap {
  static var routes = {
    "/pos-sales-detail": (context) => BlocProvider(
          create: (context) => PosSaleDetailsPresenter(),
          child: const PosSaleDetailsView(),
        ),
    "/pos-sales-list": (context) => const PosSalesListView()
  };
}
