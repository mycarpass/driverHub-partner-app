import 'dart:async';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/customers_service.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_details_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_register_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';

class RestCustomerService implements CustomersService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<CustomersResponseDto> getCustomers() async {
    try {
      Response response = await _httpClient.get("/partner/leads");

      return CustomersResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerCustomer(CustomerRegisterDto customerRegisterDto) async {
    try {
      Response response = await _httpClient.post("/partner/leads/",
          body: customerRegisterDto.toJson());
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(
      CustomerRegisterDto customerRegisterDto, String customerId) async {
    try {
      Response response = await _httpClient.put("/partner/leads/$customerId",
          body: customerRegisterDto.toJson());
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SalesDto>> getSalesByCustomer(String customerUd) async {
    try {
      // Response response = await _httpClient.get("/partner/leads");

      // return CustomersResponseDto.fromJson(response.data);

      return [
        SalesDto(
            id: 1,
            saleDate: DateTime.now(),
            paymentType: PaymentType.pix,
            services: [],
            totalAmountPaid: MoneyValue(1.00),
            discountValue: MoneyValue(0.00),
            client: SalesClient(
              personName: PersonName(""),
              phone: "",
            ),
            friendlyDate: "12/12/23",
            createdAt: "")
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CustomerDetailsDto> getCustomersDetails(String id) async {
    try {
      Response response = await _httpClient.get("/partner/leads/$id");

      return CustomerDetailsDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
