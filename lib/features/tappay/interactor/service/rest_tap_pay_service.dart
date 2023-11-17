import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:driver_hub_partner/features/tappay/interactor/service/tap_pay_service.dart';

class RestTapPayService implements TapPayService {
  final dio = Dio.Dio();

  @override
  Future<String> getConnectionToken() async {
    try {
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('sk_test_51OCMJRG0voDUKa2uDOQshjZlaIULa0qRx6Mz0sizHysDOE3hu2gK2Bp1bYOkTQrrLbAabhaOU5aC4EakM4ZwWPig004L9t7tLb'))}';
      dio.options.contentType = Dio.Headers.formUrlEncodedContentType;

      Dio.Response connectionTokenRes = await dio.post(
          "https://api.stripe.com/v1/terminal/connection_tokens",
          data: {},
          options: Dio.Options(headers: {"authorization": basicAuth}));
      if (connectionTokenRes.data['secret'] != null) {
        return connectionTokenRes.data['secret'];
      } else {
        return "";
      }
    } catch (e) {
      rethrow;
    }
  }
}
