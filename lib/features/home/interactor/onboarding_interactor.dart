import 'package:driver_hub_partner/features/home/interactor/service/dto/logo_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/onboarding_service.dart';

class OnboardingInteractor {
  final OnboardingService _onboardingService;

  OnboardingInteractor(this._onboardingService);

  Future<void> sendLogo(LogoAccountDto logoAccountDto, String partnerId) async {
    try {
      return await _onboardingService.sendLogo(logoAccountDto, partnerId);
    } catch (e) {
      rethrow;
    }
  }
}
