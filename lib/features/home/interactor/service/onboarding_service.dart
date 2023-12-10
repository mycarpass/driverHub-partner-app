import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/logo_dto.dart';

abstract class OnboardingService {
  Future<void> sendLogo(LogoAccountDto logoAccountDto);
  Future<void> saveBankAccount(BankAccountDto bankAccountDto);
}
