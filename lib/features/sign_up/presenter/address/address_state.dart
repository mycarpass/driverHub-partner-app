import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/fetch_address_response.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';

class AddressInitialState extends DHState {}

class AddressFinishedState extends DHState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddressSearchedState extends DHState {
  AddressSearchedState(this.listAddress);
  List<GeoLocationResponseDto> listAddress = [];

  @override
  List<Object> get props => [listAddress];
}

// ignore: must_be_immutable
class AddressIsSearchingState extends DHState {
  AddressIsSearchingState(this.isEnableToSearch);
  bool isEnableToSearch = false;
  @override
  List<Object> get props => [isEnableToSearch];
}

class AddressClearedState extends DHState {
  @override
  List<Object> get props => [];
}

class AddressSelectedState extends DHState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddressAvailableState extends DHState {
  AddressAvailableState(this.address);
  GeoLocationResponseDto address = GeoLocationResponseDto(
      title: "", description: "", placeId: "", reference: "");
  @override
  List<Object> get props => [address];
}

class AddressInsertLoadingState extends DHState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddressNotAvailableState extends DHState {
  AddressNotAvailableState(this.address);
  GeoLocationResponseDto address = GeoLocationResponseDto(
      title: "", description: "", placeId: "", reference: "");
  @override
  List<Object> get props => [address];
}

class AddressAddedSuccessfulState extends DHState {
  @override
  List<Object> get props => [];
}

class FetchAddressLoadingState extends DHState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchAddressSuccessfulState extends DHState {
  FetchAddressSuccessfulState(this.response);
  FetchListAddressResponseDto response =
      FetchListAddressResponseDto(addressList: []);
  @override
  List<Object> get props => [response];
}

// ignore: must_be_immutable
class AddressOptionSuccessfulState extends DHState {
  AddressOptionSuccessfulState(this.message);
  String message = "";
  @override
  List<Object> get props => [message];
}

class AddressWithouComplement extends DHState {
  final bool isWithoutComplement;
  AddressWithouComplement(this.isWithoutComplement);
  @override
  List<Object> get props => [isWithoutComplement];
}
