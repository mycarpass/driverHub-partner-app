import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';

class CheckAddressParams {
  final AddressPresenter signUpPresenter;
  String street = '';
  String number = '';
  String neighberhood = '';
  String city = "";
  String state = "";
  late GeoLocationResponseDto geoLocationResponseDto;

  CheckAddressParams(this.signUpPresenter, this.geoLocationResponseDto) {
    street = geoLocationResponseDto.title.split(",")[0];
    number = geoLocationResponseDto.title.split(",")[1];
    neighberhood = geoLocationResponseDto.description.split(",")[0];
    city =
        geoLocationResponseDto.description.split(",")[1].split("-")[0].trim();
    state = geoLocationResponseDto.description.split(",").length == 2
        ? geoLocationResponseDto.description.split(",")[0].split("-")[1].trim()
        : geoLocationResponseDto.description.split(",")[1].split("-")[1].trim();
  }
}
