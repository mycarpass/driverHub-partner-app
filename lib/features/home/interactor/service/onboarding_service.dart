import 'package:driver_hub_partner/features/home/interactor/service/dto/logo_dto.dart';

abstract class OnboardingService {
  Future<void> sendLogo(LogoAccountDto logoAccountDto, String partnerId);
}
