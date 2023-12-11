import 'package:driver_hub_partner/features/home/interactor/service/dto/subscription_response_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/subscription_service.dart';

class SubscriptionInteractor {
  final SubscriptionService _subscriptionService;

  SubscriptionInteractor(this._subscriptionService);

  Future<SubscriptionResponseDto> getSubscriptions() async {
    try {
      return await _subscriptionService.getSubscriptions();
    } catch (e) {
      rethrow;
    }
  }
}
