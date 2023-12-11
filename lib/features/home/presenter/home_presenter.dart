import 'dart:io';

import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/config/enviroment_variables.dart';
import 'package:driver_hub_partner/features/home/interactor/home_interactor.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/financial_info_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';
import 'package:driver_hub_partner/features/home/presenter/home_state.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/home/view/resources/home_deeplinks.dart';
import 'package:driver_hub_partner/features/schedules/router/params/schedule_detail_param.dart';
import 'package:driver_hub_partner/features/schedules/router/schedules_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class HomePresenter extends Cubit<DHState> {
  HomePresenter() : super(DHInitialState());

  final HomeInteractor _homeInteractor =
      DHInjector.instance.get<HomeInteractor>();

  final DHCacheManager _dhCacheManager =
      DHInjector.instance.get<DHCacheManager>();

  HomeResponseDto homeResponseDto = HomeResponseDto();
  late FinancialInfoDto financialInfoDto;
  String? deepLink;
  bool isVisible = true;
  bool isSubscribed = false;

  Future<void> load() async {
    await _getHomeInfo();
    await _getFinancialInfo();
  }

  void _configurePush() {
    OneSignal.Notifications.requestPermission(true);
    OneSignal.login(
      homeResponseDto.data.partnerData.email,
    );
  }

  Future<void> _configureRevenueCat() async {
    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_HqMGaaqXNYxpodCeFvFMkJopvCj");
    } else {
      configuration =
          PurchasesConfiguration("appl_kKamBNUKIXvKwJajplUGnUrMJqz");
    }
    await Purchases.configure(configuration);
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.logIn(homeResponseDto.data.partnerData.id.toString());
    await Purchases.setEmail(homeResponseDto.data.partnerData.email);
    await Purchases.setDisplayName(homeResponseDto.data.partnerData.name);
    await Purchases.setPhoneNumber(homeResponseDto.data.partnerData.phone);
    await Purchases.setPushToken(homeResponseDto.data.partnerData.email);
    await Purchases.setOnesignalID(DHEnvs.oneSignalToken);
  }

  Future<void> _verifySubscribe() async {
    bool isSub = await _dhCacheManager.getBool(SubscriptionTokenKey()) ?? false;
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    bool containsActiveSubscription =
        customerInfo.activeSubscriptions.isNotEmpty;
    if (isSub != containsActiveSubscription) {
      _dhCacheManager.setBool(
          SubscriptionTokenKey(), containsActiveSubscription);
      isSub = containsActiveSubscription;
    }
    isSubscribed = isSub;
  }

  void changeVisible() {
    isVisible = !isVisible;
    emit(FinancialLoadadedState(isVisible: isVisible));
    //  emit(DHSuccessState());
  }

  Future _getHomeInfo() async {
    try {
      emit(DHLoadingState());
      homeResponseDto = await _homeInteractor.getHomeInfo();
      emit(HomeLoaded(homeResponseDto));
      await _configureRevenueCat();
      _configurePush();
      await _verifySubscribe();
      if (deepLink != null) {
        openDeepLink(deepLink!);
      }
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future _getFinancialInfo() async {
    try {
      emit(FinancialLoadingState());
      financialInfoDto = await _homeInteractor.getFinancialInfo();
      emit(FinancialLoadadedState(isVisible: true));
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future<void> requestPermissions() async {
    final permissions = [
      Permission.locationWhenInUse,
      Permission.bluetooth,
      if (Platform.isAndroid) ...[
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ],
    ];

    for (final permission in permissions) {
      final result = await permission.request();
      if (result == PermissionStatus.denied ||
          result == PermissionStatus.permanentlyDenied) return;
    }
  }

  void openDeepLink(String dlink) {
    if (dlink.contains(HomeDeepLinks.schedules)) {
      String scheduleId = dlink.replaceAll(HomeDeepLinks.schedules, "");
      Navigator.pushNamed(NavigationService.navigatorKey.currentContext!,
          SchedulesRoutes.scheduleDetail,
          arguments: ScheduleDetailParams(scheduleId: int.parse(scheduleId)));
    }
  }
}
