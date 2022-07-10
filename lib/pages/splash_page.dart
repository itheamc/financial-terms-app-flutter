import 'dart:async';
import 'dart:math';

import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/handler/session/session_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

    Timer(Duration(milliseconds: Random().nextInt(2500) + 1000),
        _handleNextRoute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icon/ftlogo.png",
                  width: Get.width * 0.3,
                  height: Get.width * 0.3,
                ),
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        theme.primaryColor,
                        theme.colorScheme.secondary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Financial Terms",
                    style: GoogleFonts.jost(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: FinancialTermsAppTheme.paddingSmall,
              ),
              child: Text(
                "Code with ❤ by @mit",
                style: GoogleFonts.jost(
                  fontSize: 10.0,
                ),
              ),
            ),
          )
        ],
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
