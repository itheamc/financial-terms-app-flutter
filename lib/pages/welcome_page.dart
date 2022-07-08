import 'package:financial_terms/components/a_button.dart';
import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../handler/session/session_handler.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FinancialTermsAppTheme.paddingMedium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello There,",
                    style: GoogleFonts.arsenal(
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(
                    height: FinancialTermsAppTheme.paddingXSmall,
                  ),
                  Text(
                    "Welcome to Financial Terms!",
                    style: GoogleFonts.arsenal(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: FinancialTermsAppTheme.paddingMedium),
            child: Image.asset(
              "assets/images/learn.png",
            ),
          ),
          AButton(
            onPressed: () async {
              final session = Get.find<SessionHandler>();
              await session.used(true);
              Get.offNamed(Routes.home);
            },
            label: "Let's Start Learning",
            labelStyle: GoogleFonts.arsenal(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
