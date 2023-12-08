import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/address_geo_interector.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/address_interector.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/fetch_address_response.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/verify_address_response_dto.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/address/address_state.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/widgets/address_options_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPresenter extends Cubit<DHState> {
  AddressPresenter() : super(AddressInitialState());

  final AddressGeoInteractor _geoAddressInteractor =
      DHInjector.instance.get<AddressGeoInteractor>();

  final AddressInteractor _addressInteractor =
      DHInjector.instance.get<AddressInteractor>();

  List<GeoLocationResponseDto> addressList = [];

  List<FetchAddressReponseDto> myAdressesList = [];

  GeoLocationResponseDto? addressSelected;

  String searchText = "";

  bool isWithoutComplement = false;

  void changeIsWithoutComplement() {
    isWithoutComplement = !isWithoutComplement;
    emit(AddressWithouComplement(isWithoutComplement));
  }

  void isSearching(String query) {
    emit(AddressIsSearchingState(query.length >= 5));
  }

  void clear() {
    searchText = "";
    addressList = [];
    emit(AddressClearedState());
  }

  void selectAddress(GeoLocationResponseDto address) {
    addressSelected = address;
    emit(AddressSelectedState());
  }

  bool isFilledHouseNumber(String address) {
    if (address.contains(",") && address.contains(RegExp(r'[0-9]'))) {
      return true;
    }
    return false;
  }

  void search() async {
    addressList = await _geoAddressInteractor.fetchLocation(searchText);
    emit(AddressSearchedState(addressList));
  }

  String concatenateAddressNumber(String address, String addressNumber) {
    return "$address, $addressNumber";
  }

  Future<void> verifyAddress(GeoLocationResponseDto address) async {
    try {
      emit(DHLoadingState());
      GeoCoords coords = await _geoAddressInteractor.fetchLatLong(address);
      GeoLocationResponseDto newAddress = GeoLocationResponseDto(
          title: address.title,
          description: address.description,
          placeId: address.placeId,
          reference: address.reference);
      newAddress.coords = coords;

      VerifyAddressReponseDto response =
          await _addressInteractor.verifyAddress(coords.lat, coords.lon);
      if (response.isAvailable) {
        emit(AddressAvailableState(newAddress));
      } else {
        emit(AddressNotAvailableState(newAddress));
      }
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao verificar a localização, tente novamente."));
    }
  }

  Future<void> fetchLatLong(GeoLocationResponseDto address) async {
    try {
      emit(DHLoadingState());
      GeoCoords coords = await _geoAddressInteractor.fetchLatLong(address);
      GeoLocationResponseDto newAddress = GeoLocationResponseDto(
          title: address.title,
          description: address.description,
          placeId: address.placeId,
          reference: address.reference);
      newAddress.coords = coords;
      addressSelected = newAddress;
    } catch (e) {
      emit(DHErrorState(
          error: "Ocorreu um erro ao buscar a localização, tente novamente."));
    }
  }

  Future<void> insertAddress(
      GeoLocationResponseDto address, String complement) async {
    try {
      emit(DHLoadingState());
      await _addressInteractor.insertAddress(address, complement);
      addressList = [];
      isWithoutComplement = false;
      emit(AddressAddedSuccessfulState());
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao salvar o endereço, tente novamente mais tarde"));
    }
  }

  Future<void> fetchAddress() async {
    try {
      emit(FetchAddressLoadingState());
      FetchListAddressResponseDto response =
          await _addressInteractor.fetchAddress();
      myAdressesList = response.addressList;
      emit(FetchAddressSuccessfulState(response));
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao carregar endereços, tente novamente mais tarde"));
    }
  }

  Future<void> actionOption(
      AddressActionOption optionSelected, int idAddress) async {
    switch (optionSelected) {
      case AddressActionOption.select:
        await selectAddressById(idAddress);
        await fetchAddress();
        break;
      case AddressActionOption.homeset:
        await setHomebyAddressId(idAddress);
        await fetchAddress();
        break;
      case AddressActionOption.workset:
        await setWorkbyAddressId(idAddress);
        await fetchAddress();
        break;
      case AddressActionOption.delete:
        await deleteAddressId(idAddress);
        await fetchAddress();
        break;
      default:
        break;
    }
  }

  Future<void> selectAddressById(int idAddress) async {
    try {
      emit(FetchAddressLoadingState());
      await _addressInteractor.selectAddressById(idAddress);

      emit(AddressOptionSuccessfulState(
          "O endereço foi selecionado com sucesso. Agora ele é o seu endereço principal para antendimento."));
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao selecionar o endereço, tente novamente mais tarde"));
    }
  }

  Future<void> setHomebyAddressId(int idAddress) async {
    try {
      emit(FetchAddressLoadingState());
      await _addressInteractor.setHomeAddressById(idAddress);

      emit(AddressOptionSuccessfulState(
          "O endereço foi atribuído para sua Casa"));
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao atribuir o endereço para sua casa, tente novamente mais tarde"));
    }
  }

  Future<void> setWorkbyAddressId(int idAddress) async {
    try {
      emit(FetchAddressLoadingState());
      await _addressInteractor.setWorkAddressById(idAddress);

      emit(AddressOptionSuccessfulState(
          "O endereço foi atribuído para seu Trabalho"));
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao atribuir o endereço para seu trabalho, tente novamente mais tarde"));
    }
  }

  Future<void> deleteAddressId(int idAddress) async {
    try {
      emit(FetchAddressLoadingState());
      await _addressInteractor.deleteAddressById(idAddress);

      emit(AddressOptionSuccessfulState("O endereço foi deletado com sucesso"));
    } catch (e) {
      emit(DHErrorState(
          error:
              "Ocorreu um erro ao deletar o endereço, tente novamente mais tarde"));
    }
  }
}
