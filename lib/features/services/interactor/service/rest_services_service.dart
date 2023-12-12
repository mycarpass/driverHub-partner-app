import 'dart:async';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/services_service.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

class RestServicesService implements ServicesService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<ServicesResponseDto> getServicesDropDown() async {
    try {
      Response response = await _httpClient.get("/services");

      return ServicesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> saveService(ServiceEntity entity) async {
    try {
      Response response =
          await _httpClient.post("/partner/new-service", body: entity.toJson());

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<ServicesResponseDto> getPartnerServices() async {
    try {
      Response response = await _httpClient.get("/partner/services");

      return ServicesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
