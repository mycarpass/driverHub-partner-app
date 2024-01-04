import 'dart:async';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/pos_sales_service.dart';

class RestPosSalesService implements PosSalesService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<PosSalesResponseDto> getPosSales() async {
    try {
      Response response = await _httpClient.get("/partner/after-sales");

      return PosSalesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeMadeContact(bool isMadeContact, int id) async {
    try {
      await _httpClient.put(
        "/partner/after-sale/set-contact/$id",
        body: {'made_contact': isMadeContact},
      );
    } catch (e) {
      rethrow;
    }
  }
}
