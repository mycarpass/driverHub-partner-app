import 'dart:async';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/create_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sale_details_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/update_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/sales_service.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class RestSalesService implements SalesService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<SalesResponseDto> getSales() async {
    try {
      Response response = await _httpClient.get("/partner/sales");

      return SalesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveSale(CreateSaleDto createSaleDto) async {
    try {
      await _httpClient.post(
        "/partner/sale",
        body: createSaleDto.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SaleDetailsDto> getDetails(String id) async {
    try {
      Response response = await _httpClient.get("/partner/sale/$id");

      return SaleDetailsDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSale(UpdateSaleDto updateSaleDto) async {
    try {
      await _httpClient.put(
        "/partner/sale/${updateSaleDto.id}",
        body: updateSaleDto.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeSalePhoto(CheckListPhoto checkListPhoto) async {
    try {
      await _httpClient.put(
        "/partner/checklist-photo/${checkListPhoto.id}",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> saveSalePhoto(CheckListPhoto checkListPhoto) async {
    try {
      var formData = await checkListPhoto.toSavePhotoMap();
      Response response = await _httpClient
          .post("/partner/sale/checklist-photo", body: formData);
      return response.data["photo_id"];
    } catch (e) {
      rethrow;
    }
  }
}
