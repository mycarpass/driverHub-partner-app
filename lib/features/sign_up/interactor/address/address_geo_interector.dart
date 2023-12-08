import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/geo_service.dart';

class AddressGeoInteractor {
  AddressGeoInteractor();

  final GeoService _geoService = DHInjector.instance.get<GeoService>();

  Future fetchLocation(String address) async {
    try {
      var response = await _geoService.fetchLocationByAddress(address);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future fetchLatLong(GeoLocationResponseDto address) async {
    try {
      var response = await _geoService.fetchLatLongByReference(
          address.reference, address.placeId);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
