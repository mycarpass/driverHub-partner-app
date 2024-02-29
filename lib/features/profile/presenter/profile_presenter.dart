import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/home_interactor.dart';
import 'package:driver_hub_partner/features/login/interactor/cache_key/email_key.dart';
import 'package:driver_hub_partner/features/profile/presenter/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
// ignore: depend_on_referenced_packages
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePresenter extends Cubit<DHState> {
  ProfilePresenter() : super(DHInitialState());

  final DHCacheManager _cacheManager =
      DHInjector.instance.get<DHCacheManager>();

  final HomeInteractor _homeInteractor =
      DHInjector.instance.get<HomeInteractor>();

  final InAppReview inAppReview = InAppReview.instance;

  String getName() {
    return _homeInteractor.response.data.partnerData.name;
  }

  String getEmail() {
    return _homeInteractor.response.data.partnerData.email;
  }

  String getDocumentNumber() {
    return _homeInteractor.response.data.partnerData.document;
  }

  String getInitialsName() {
    String name = _homeInteractor.response.data.partnerData.name;
    String firstLetter = name.trim().substring(0, 1).toUpperCase();
    String secondLetter = "";
    List<String> nameSplitted = name.trim().split(" ");
    if (nameSplitted.length >= 2) {
      String secondNameSplitted = nameSplitted[nameSplitted.length - 1];
      secondLetter = secondNameSplitted.substring(0, 1).toUpperCase();
    } else {
      secondLetter = name.trim().substring(1, 2).toUpperCase();
    }
    return "$firstLetter$secondLetter";
  }

  String? getUrlLogo() {
    return _homeInteractor.response.data.partnerData.thumb == ""
        ? null
        : _homeInteractor.response.data.partnerData.thumb;
  }

  void openUrl(Uri uri) async {
    //Uri uri = Uri.parse(url);
    await canLaunchUrl(uri) ? _launchInBrowser(uri) : null;
  }

  void requestAppReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void logout() {
    Sentry.configureScope((scope) => scope.setUser(null));

    _cacheManager.reset();

    OneSignal.logout();

    emit(LogoutSuccessState());
  }

  Future<bool> isServiceProvider() async {
    String? role = await _cacheManager.getString(RoleTokenKey());
    return role != null && role == "SERVICE_PROVIDER";
  }
}
