import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/home/interactor/service/onboarding_service.dart';

class RestOnboardingService implements OnboardingService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();
}
