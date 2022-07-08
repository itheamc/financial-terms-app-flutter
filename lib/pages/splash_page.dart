import 'dart:async';

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
      body: Center(child: CircularProgressIndicator()),
    );
  }

  /// On Timer Finished
  void _handleNextRoute() {
    Get.offNamed(Routes.home);
  }
}
