import 'dart:io';

import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/subscription_interactor.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_state.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/bottomsheets/subscription_intro_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPresenter extends Cubit<DHState> {
  SubscriptionPresenter() : super(DHInitialState());

  final DHCacheManager _dhCacheManager =
      DHInjector.instance.get<DHCacheManager>();

  SubscriptionInteractor subscriptionInteractor =
      DHInjector.instance.get<SubscriptionInteractor>();

  List<StoreProduct> storeProducts = [];
  int indexPlanSelected = 0;
  bool isSubscribed = false;

  void start() async {
    await _verifySubscribe();
    _loadProducts();
  }

  Future _loadProducts() async {
    try {
      storeProducts = await Purchases.getProducts(
          Platform.isAndroid
              ? [
                  'android_monthly_partners:android-monthly-partners-plan',
                  'android_monthly_partners:android-yearly-partners-plan'
                ]
              : ['ios_monthly_partners', 'ios_yearly_partners'],
          productCategory: ProductCategory.subscription);
      storeProducts.sort((a, b) => a.price.compareTo(b.price));
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> openPayWall(BuildContext context) async {
    return await showModalBottomSheet<bool?>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
          value: this,
          child: SubscriptionIntroBottomSheet(
            storeProducts: storeProducts,
          )),
    );
  }

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
      } else {
        _dhCacheManager.setBool(SubscriptionTokenKey(), false);
      }
    });
    await Purchases.purchaseStoreProduct(product);
  }

  Future<void> _verifySubscribe() async {
    // bool isSub = await _dhCacheManager.getBool(SubscriptionTokenKey()) ?? false;
    // int daysOfTrial = await _dhCacheManager.getInt(DaysTrialKey()) ?? 0;
    // CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    // bool containsActiveSubscription =
    //     customerInfo.activeSubscriptions.isNotEmpty;
    // if (isSub != containsActiveSubscription) {
    //   _dhCacheManager.setBool(
    //       SubscriptionTokenKey(), containsActiveSubscription);
    //   isSub = containsActiveSubscription;
    // }

    // if (!isSub && daysOfTrial > 0) {
    //   ///TODO UNCOMENT
    //   isSubscribed = false;
    // } else {
    //   isSubscribed = false;
    // }

    var response = await subscriptionInteractor.getReceivable();
    isSubscribed = response.isSubscriptionActive;
    emit(SubscribedIsUpdated(isSubscribed: response.isSubscriptionActive));
  }

  void openUrl(Uri uri) async {
    //Uri uri = Uri.parse(url);
    await canLaunchUrl(uri) ? _launchInBrowser(uri) : null;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class SubscriptionTokenKey implements CacheKey {
  @override
  String get key => "is_subscribed";
}

class DaysTrialKey implements CacheKey {
  @override
  String get key => "days_trial";
}
