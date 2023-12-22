import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/customers_interactor.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_details_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsPresenter extends Cubit<DHState> {
  CustomerDetailsPresenter() : super(DHInitialState());

  CustomersInteractor customersInteractor =
      DHInjector.instance.get<CustomersInteractor>();

  List<SalesDto> salesByCustomer = [];

  late CustomerDetailsDto customerDetailsDto;

  void load(String customerId) async {
    try {
      emit(DHLoadingState());

      await Future.delayed(const Duration(seconds: 3));

      customerDetailsDto =
          await customersInteractor.getCustomersDetails(customerId);
      customerDetailsDto.data.salesHistory;
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void openUrl(Uri uri) async {
    await canLaunchUrl(uri) ? _launchInBrowser(uri) : null;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
