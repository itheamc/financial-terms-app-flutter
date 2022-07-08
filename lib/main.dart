import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/controllers/terms_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes.dart';
import 'controllers/connectivity_controller.dart';
import 'handler/route/routes_handler.dart';

void main() {
  runApp(const FinancialTermsApp());
}

class FinancialTermsApp extends StatelessWidget {
  const FinancialTermsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aTheme = ATheme();
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
