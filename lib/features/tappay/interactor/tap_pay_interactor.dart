import 'package:driver_hub_partner/features/tappay/interactor/service/tap_pay_service.dart';

class TapPayInterector {
  final TapPayService _tapPayService;

  TapPayInterector(this._tapPayService);

  Future<String> getConnectionToken() async {
    try {
      return await _tapPayService.getConnectionToken();
    } catch (e) {
      rethrow;
    }
  }
}
