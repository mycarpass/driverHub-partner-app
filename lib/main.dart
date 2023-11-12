// ignore_for_file: unused_import

import 'package:dh_http_client/http_client_module.dart';
import 'package:dh_ui_kit/view/themes/main_theme.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_ui_kit/ui_kit_module.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/config/enviroment_variables.dart';
import 'package:driver_hub_partner/features/login/login_module.dart';
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

List<DHModule> moduleList = [
  DHCacheManagerModule(),
  HttpClientModule(DHEnvs.apiBaseUrl),
  WelcomeModule(),
  LoginModule(),
  UiKitModule(),
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

  runApp(const AppEntryPoint());

  // OneSignal.Debug.setLogLevel(OSLogLevel.debug);

  // OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  // OneSignal.consentRequired(false);

  // OneSignal.initialize(DHEnvs.oneSignalToken);
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
      title: 'DriverHub',
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
