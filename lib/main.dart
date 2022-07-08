import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/controllers/terms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes.dart';
import 'controllers/connectivity_controller.dart';
import 'handler/route/routes_handler.dart';
import 'handler/session/session_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// For Session Handling
  Get.putAsync<SessionHandler>(
    () async {
      final sessionHandler = await SessionHandler.getInstance();
      return sessionHandler;
    },
    permanent: true,
  );

  runApp(const FinancialTermsApp());
}

class FinancialTermsApp extends StatelessWidget {
  const FinancialTermsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aTheme = FinancialTermsAppTheme();
    return GetMaterialApp(
      title: 'Financial Terms',
      theme: aTheme.theme,
      darkTheme: aTheme.darkTheme,
      navigatorKey: Get.key,
      initialRoute: Routes.splash,
      onGenerateRoute: RoutesHandler.handleOnGenerateRoute,
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(
            () => ConnectivityController(),
          );
          Get.lazyPut(
            () => TermsController(),
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
