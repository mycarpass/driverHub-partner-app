// ignore_for_file: unused_import

import 'dart:io';

import 'package:dh_http_client/http_client_module.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_ui_kit/ui_kit_module.dart';
import 'package:dh_ui_kit/view/themes/main_theme.dart';
import 'package:driver_hub_partner/config/enviroment_variables.dart';
import 'package:driver_hub_partner/features/customers/customers_module.dart';
import 'package:driver_hub_partner/features/home/home_module.dart';
import 'package:driver_hub_partner/features/login/login_module.dart';
import 'package:driver_hub_partner/features/pos_sales/pos_sales_module.dart';
import 'package:driver_hub_partner/features/profile/profile_module.dart';
import 'package:driver_hub_partner/features/sales/sales_module.dart';
import 'package:driver_hub_partner/features/schedules/schedules_module.dart';
import 'package:driver_hub_partner/features/services/services_module.dart';
import 'package:driver_hub_partner/features/sign_up/sign_up_module.dart';
import 'package:driver_hub_partner/features/welcome/welcome_module.dart';
import 'package:driver_hub_partner/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dh_notification/notification_module.dart';
// import 'config/firebase_options.dart';
import 'package:dh_cache_manager/cache_manager_module.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

List<DHModule> moduleList = [
  DHCacheManagerModule(),
  HttpClientModule(DHEnvs.apiBaseUrl),
  WelcomeModule(),
  LoginModule(),
  UiKitModule(),
  HomeModule(),
  SchedulesModule(),
  ProfileModule(),
  CustomersModule(),
  SalesModule(),
  SignUpModule(),
  ServicesModule(),
  PosSalesModule(),
  NotificationPackageModule(notificationToken: DHEnvs.oneSignalToken)
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  // };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  for (var element in moduleList) {
    element.registerProviders();
  }

  PurchasesConfiguration configuration;
  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration("goog_HqMGaaqXNYxpodCeFvFMkJopvCj");
  } else {
    configuration = PurchasesConfiguration("appl_kKamBNUKIXvKwJajplUGnUrMJqz");
  }
  await Purchases.configure(configuration);

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://6a3c233d5ecd75299def9f76583fdd64@o4506476887539712.ingest.sentry.io/4506479616131072';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const AppEntryPoint()),
  );
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(dynamic)> routes = {};

    for (var element in moduleList) {
      routes.addAll(element.routes);
    }
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriverHub Parceiros',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
      routes: getRoutes(),
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: dhThemeData,
    );
  }
}
