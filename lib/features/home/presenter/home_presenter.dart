import 'dart:io';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/home_interactor.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';
import 'package:driver_hub_partner/features/home/presenter/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePresenter extends Cubit<DHState> {
  HomePresenter() : super(DHInitialState());

  final HomeInteractor _homeInteractor =
      DHInjector.instance.get<HomeInteractor>();

  HomeResponseDto homeResponseDto = HomeResponseDto();
  bool isVisible = true;

  Future<void> load() async {
    await _getHomeInfo();
    _configurePush();
  }

  void _configurePush() {
    OneSignal.Notifications.requestPermission(true);
    OneSignal.login(
      homeResponseDto.data.partnerData.email,
    );
  }

  void changeVisible() {
    isVisible = !isVisible;
    emit(VisibleIsChanged(isVisible));
    //  emit(DHSuccessState());
  }

  Future _getHomeInfo() async {
    try {
      emit(DHLoadingState());
      homeResponseDto = await _homeInteractor.getHomeInfo();
      emit(HomeLoaded(homeResponseDto));
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
}
