import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';

abstract class GeoService {
  Future<List<GeoLocationResponseDto>> fetchLocationByAddress(String address);
  Future<GeoCoords> fetchLatLongByReference(String refernece, String placeId);
}
