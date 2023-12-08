import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/address_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/fetch_address_response.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/insert_address_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/verify_address_dto.dart';

class AddressInteractor {
  AddressInteractor();

  final AddressService _adddresService =
      DHInjector.instance.get<AddressService>();

  Future verifyAddress(double lat, double lon) async {
    try {
      var response = await _adddresService
          .verifyAddress(VerifyAddressDto(lat: lat, lon: lon));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future insertAddress(
      GeoLocationResponseDto address, String complement) async {
    try {
      var response = await _adddresService.insertAddress(
        InsertAddressDto(
          lat: address.coords?.lat,
          lon: address.coords?.lon,
          mainAddress: address.title,
          secondaryAddress: address.description,
          placeId: address.placeId,
          reference: address.reference,
          complement: complement,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<FetchListAddressResponseDto> fetchAddress() async {
    try {
      var response = await _adddresService.fetchAddress();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future selectAddressById(int idAddress) async {
    try {
      var response = await _adddresService.selectAddressById(idAddress);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future setHomeAddressById(int idAddress) async {
    try {
      var response = await _adddresService.setHomeAddressById(idAddress);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future setWorkAddressById(int idAddress) async {
    try {
      var response = await _adddresService.setWorkAddressById(idAddress);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteAddressById(int idAddress) async {
    try {
      var response = await _adddresService.deleteAddressById(idAddress);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
