import 'package:driver_hub_partner/features/home/interactor/service/dto/subscription_response_dto.dart';

abstract class SubscriptionService {
  Future<SubscriptionResponseDto> getSubscriptions();
}
