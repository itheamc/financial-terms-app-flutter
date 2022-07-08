import 'dart:async';

import 'package:financial_terms/components/a_loading_indicator.dart';
import 'package:financial_terms/handler/session/session_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2000), _handleNextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ALoadingIndicator(
        label: "Financial Terms",
        size: 75.0,
      ),
    );
  }

  /// On Timer Finished
  void _handleNextRoute() {
    final session = Get.find<SessionHandler>();

    if (session.newUser) {
      Get.offNamed(Routes.welcome);
      return;
    }

    Get.offNamed(Routes.home);
  }
}
