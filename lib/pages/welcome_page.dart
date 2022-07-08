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
                horizontal: ATheme.paddingMedium,
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
                    height: ATheme.paddingXSmall,
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
            padding: EdgeInsets.symmetric(horizontal: ATheme.paddingMedium),
            child: Image.asset(
              "assets/images/learn.png",
            ),
          ),
          Material(
            color: theme.buttonTheme.colorScheme?.primary,
            borderRadius: BorderRadius.circular(ATheme.radiusXLarge),
            elevation: 50.0,
            shadowColor: theme.dividerColor.withOpacity(0.10),
            child: InkWell(
              onTap: () async {
                final session = Get.find<SessionHandler>();
                await session.used(true);
                Get.offNamed(Routes.home);
              },
              borderRadius: BorderRadius.circular(ATheme.radiusXLarge),
              child: Ink(
                padding: EdgeInsets.symmetric(
                  horizontal: ATheme.paddingXXXLarge,
                  vertical: ATheme.paddingSmall + ATheme.paddingXXSmall,
                ),
                child: Text(
                  "Let's Start Learning",
                  style: GoogleFonts.arsenal(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
