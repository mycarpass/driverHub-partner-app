import 'package:dh_dependency_injection/dh_dependency_injection.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/logo_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/onboarding_service.dart';
import 'package:dio/dio.dart';

class RestOnboardingService implements OnboardingService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<void> sendLogo(LogoAccountDto logoAccountDto, String partnerId) async {
    try {
      var formData = FormData.fromMap({
        "thumb": await MultipartFile.fromFile(logoAccountDto.pathLogo ?? "",
            filename: 'thumb.jpeg'),
        "background": logoAccountDto.imageBackgroundFile != null
            ? await MultipartFile.fromFile(logoAccountDto.pathBackground ?? "",
                filename: 'background.jpeg')
            : null,
      });
      //   dynamic response = await Dio().post('/info', data: formData);
      // var multipartLogo = await MultipartFile.fromFile(
      //     logoAccountDto.pathLogo ?? "",
      //     filename: 'thumb.jpeg');
      dynamic response =
          await _httpClient.post("/partner/update/$partnerId", body: formData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
