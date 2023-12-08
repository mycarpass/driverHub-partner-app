import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/address_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/fetch_address_response.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/insert_address_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/verify_address_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/verify_address_response_dto.dart';

class RestAddressService implements AddressService {
  final DHHttpClient httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<VerifyAddressReponseDto> verifyAddress(
      VerifyAddressDto verifyAddressDto) async {
    try {
      var response = await httpClient.post("/address/verify",
          body: verifyAddressDto.toJson());

      return VerifyAddressReponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> insertAddress(InsertAddressDto insertAddressDto) async {
    try {
      var response = await httpClient.post("/user/address/store",
          body: insertAddressDto.toJson());
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FetchListAddressResponseDto> fetchAddress() async {
    try {
      var response = await httpClient.get(
        "/user/addresses",
      );
      return FetchListAddressResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> selectAddressById(int idAddress) async {
    try {
      var response = await httpClient.get("/address/select/$idAddress");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> setHomeAddressById(int idAddress) async {
    try {
      var response = await httpClient
          .put("/user/address/update/$idAddress", body: {'type': 2});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> setWorkAddressById(int idAddress) async {
    try {
      var response = await httpClient
          .put("/user/address/update/$idAddress", body: {'type': 1});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteAddressById(int idAddress) async {
    try {
      var response = await httpClient.delete(
        "/user/address/$idAddress",
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
