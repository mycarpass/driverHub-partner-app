import 'package:dh_dependency_injection/dh_dependency_injection.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/receivable_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/subscription_response_dto.dart';

import 'package:driver_hub_partner/features/home/interactor/service/subscription_service.dart';

class RestSubscriptionService implements SubscriptionService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<SubscriptionResponseDto> getSubscriptions() async {
    try {
      dynamic response = await _httpClient.get("/partner/bank-account");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ReceivableDto> getReceivable() async {
    try {
      dynamic response = await _httpClient.get("/partner/receivables");
      return ReceivableDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
