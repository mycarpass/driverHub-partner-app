import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/fetch_address_response.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/insert_address_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/verify_address_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/verify_address_response_dto.dart';

abstract class AddressService {
  Future<VerifyAddressReponseDto> verifyAddress(
      VerifyAddressDto verifyAddressDto);
  Future<dynamic> insertAddress(InsertAddressDto insertAddressDto);
  Future<FetchListAddressResponseDto> fetchAddress();
  Future<dynamic> selectAddressById(int idAddress);
  Future<dynamic> setHomeAddressById(int idAddress);
  Future<dynamic> setWorkAddressById(int idAddress);
  Future<dynamic> deleteAddressById(int idAddress);
}
