import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/geo_service.dart';

class RestGeoService implements GeoService {
  final DHHttpClient httpClient =
      DHInjector.instance.get<DHHttpClient>(instanceName: "geoClient");

  @override
  Future<List<GeoLocationResponseDto>> fetchLocationByAddress(
      String address) async {
    try {
      var response = await httpClient
          .get("/maps/api/place/autocomplete/json", queryParams: {
        "input": address,
        "language": "pt_BR",
        "key": "AIzaSyCmrsKYQD0zbQLKYvcD74Hq0i_TV8uHAsQ",
      });
      return GeoLocationResponseDto.fromJson(response.data["predictions"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GeoCoords> fetchLatLongByReference(
      String refernece, String placeId) async {
    try {
      var response =
          await httpClient.get("/maps/api/place/details/json", queryParams: {
        "place_id": placeId,
        "fields": "geometry",
        "key": "AIzaSyCmrsKYQD0zbQLKYvcD74Hq0i_TV8uHAsQ",
      });
      return GeoCoords.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
