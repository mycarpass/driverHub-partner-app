import 'package:driver_hub_partner/features/customers/interactor/service/customers_service.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_details_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_register_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';

class CustomersInteractor {
  final CustomersService _customersService;

  CustomersInteractor(this._customersService);

  Future<CustomersResponseDto> getCustomers() async {
    try {
      return await _customersService.getCustomers();
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerDetailsDto> getCustomersDetails(String id) async {
    try {
      return await _customersService.getCustomersDetails(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SalesDto>> getAllSalesByCustomer(String customerId) async {
    try {
      return await _customersService.getSalesByCustomer(customerId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerCustomer(CustomerRegisterDto customerRegisterDto) async {
    await _customersService.registerCustomer(customerRegisterDto);
  }
}
