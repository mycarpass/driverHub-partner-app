import 'dart:async';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/customers_service.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';

class RestCustomerService implements CustomersService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<CustomersResponseDto> getCustomers() async {
    try {
      Response response = await _httpClient.get("/customers");

      return CustomersResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
