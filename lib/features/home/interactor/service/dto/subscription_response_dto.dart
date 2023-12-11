import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';

class SubscriptionResponseDto {
  late PartnerDataDto partnerData;

  SubscriptionResponseDto.fromJson(Map<String, dynamic> json) {
    partnerData = PartnerDataDto.fromJson(json);
  }
  SubscriptionResponseDto();
}
