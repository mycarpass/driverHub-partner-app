import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/subscription_interactor.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPresenter extends Cubit<DHState> {
  SubscriptionPresenter() : super(DHInitialState());

  final SubscriptionInteractor _subscriptionInteractor =
      DHInjector.instance.get<SubscriptionInteractor>();

  final DHCacheManager _dhCacheManager =
      DHInjector.instance.get<DHCacheManager>();

  int indexPlanSelected = 0;

  Future<void> selectPlan(int indexPlan) async {
    indexPlanSelected = indexPlan;
    emit(PlanIsSelected(index: indexPlan));
  }

  Future<void> restorePurchase() async {
    await Purchases.restorePurchases();
  }

  Future<void> purchase(StoreProduct product) async {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      if (customerInfo.activeSubscriptions.isNotEmpty) {
        _dhCacheManager.setBool(SubscriptionTokenKey(), true);
        print('tem assinatura');
      } else {
        _dhCacheManager.setBool(SubscriptionTokenKey(), false);
        print('nao tem assinatura');
      }
    });
    await Purchases.purchaseStoreProduct(product);
  }
}

class SubscriptionTokenKey implements CacheKey {
  @override
  String get key => "is_subscribed";
}
