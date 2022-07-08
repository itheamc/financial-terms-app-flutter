import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancialTermsAppTheme {
  final Color _primaryColor = const Color(0xff382e75);
  final Color _secondaryColor = const Color(0xff7c6bdb);

  static Gradient linearGradient([double opacity = 1.0]) => LinearGradient(
        colors: [
          const Color(0xff382e75).withOpacity(opacity),
          const Color(0xff7c6bdb).withOpacity(opacity)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static double get radiusXLarge => 24.0;

  static double get radiusLarge => 18.0;

  static double get radius => 16.0;

  static double get radiusMedium => 12.0;

  static double get radiusSmall => 8.0;

  static double get radiusXSmall => 4.0;

  static double get radiusXXSmall => 2.0;

  static double get radiusXXXSmall => 1.0;

  static double radiusCircular(double size) => size / 2;

  static double get paddingXXXSmall => 1.25;

  static double get paddingXXSmall => 2.5;

  static double get paddingXSmall => 5.0;

  static double get paddingSmall => 10.0;

  static double get paddingMedium => 15.0;

  static double get paddingLarge => 20.0;

  static double get paddingXLarge => 25.0;

  static double get paddingXXLarge => 30.0;

  static double get paddingXXXLarge => 36.0;

  static double get dividerXSmall => 0.5;

  static double get dividerSmall => 1.0;

  static double get dividerLarge => 2.0;

  static Duration get durationFast => const Duration(milliseconds: 150);

  static Duration get durationMedium => const Duration(milliseconds: 225);

  static Duration get durationSlow => const Duration(milliseconds: 350);

  static Duration get durationTooSlow => const Duration(milliseconds: 1000);

  static Duration get durationTooMuchSlow => const Duration(milliseconds: 2500);

  final MaterialColor _kSwatch = const MaterialColor(
    0xff28293D,
    {
      50: Color(0xffe6e6ee),
      100: Color(0xffcdcede),
      200: Color(0xff9c9dbe),
      300: Color(0xff6a6d9d),
      400: Color(0xff484a6e),
      500: Color(0xff28293D),
      600: Color(0xff262639),
      700: Color(0xff242436),
      800: Color(0xff222233),
      900: Color(0xff202030),
    },
  );

  final Color _kPrimaryColor = Colors.indigo;
  final Color _kAccentColor = const Color(0xFF8cba37);
  final Color _kHintColor = const Color(0xffbcbcbc);
  final Color _kDividerColor = const Color(0xaededede);
  final Color _kErrorColor = const Color(0xffcd0909);
  final Color _kButtonColor = const Color(0xffdbddf2);
  final Color _kButtonSecondaryDarkColor = const Color(0xff929293);
  final Color _kButtonSecondaryLightColor = const Color(0xffe4e4e5);
  final Color _kBackgroundColor = Colors.white;
  final Color _kBackgroundColorDark = const Color(0xff222233);

  ThemeData get theme => ThemeData(
        primarySwatch: _kSwatch,
        // textSelectionTheme: _textSelectionTheme,
        colorScheme: ColorScheme(
          primary: _primaryColor,
          secondary: _secondaryColor,
          surface: Colors.white,
          background: _kBackgroundColor,
          error: _kErrorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: _kSwatch,
          onBackground: _kSwatch,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        errorColor: _kErrorColor,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 36,
          colorScheme: ColorScheme(
            primary: _kButtonColor,
            secondary: _kButtonSecondaryLightColor,
            surface: _kButtonColor,
            background: _kButtonColor,
            error: _kErrorColor,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
            onError: Colors.white,
            brightness: Brightness.dark,
          ),
          buttonColor: _secondaryColor,
        ),
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        primaryColor: _primaryColor,
        canvasColor: Colors.white,
        cardColor: Colors.white,
        secondaryHeaderColor: _primaryColor,
        backgroundColor: _kSwatch[50],
        dividerColor: _kDividerColor,
        hintColor: _kSwatch[200],
        scaffoldBackgroundColor: _kBackgroundColor,
        textTheme: GoogleFonts.latoTextTheme(),
        // inputDecorationTheme: _inputTheme,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          titleTextStyle: GoogleFonts.lato(),
          toolbarTextStyle: GoogleFonts.lato(),
          // foregroundColor: _textTheme.button?.color,
          color: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: _kSwatch[50]!,
          disabledColor: _kSwatch,
          selectedColor: _secondaryColor,
          secondarySelectedColor: _secondaryColor,
          padding: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelStyle: GoogleFonts.lato(),
          // secondaryLabelStyle:
          //     _textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
          brightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: _kSwatch),
        fontFamily: GoogleFonts.lato().fontFamily,
      );

  ThemeData get darkTheme => ThemeData(
        primarySwatch: _kSwatch,
        colorScheme: ColorScheme(
          primary: _primaryColor,
          secondary: _secondaryColor,
          surface: _kBackgroundColorDark,
          background: _kBackgroundColorDark,
          error: _kErrorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        errorColor: _kErrorColor,
        // textSelectionTheme: _textSelectionTheme,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 36,
          colorScheme: ColorScheme(
            primary: _kButtonColor,
            secondary: _kButtonSecondaryDarkColor,
            surface: _kButtonColor,
            background: _kButtonColor,
            error: _kErrorColor,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
            onError: Colors.white,
            brightness: Brightness.dark,
          ),
          buttonColor: _secondaryColor,
        ),
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        // inputDecorationTheme: _inputThemeDark,
        primaryColor: _primaryColor,
        canvasColor: _kBackgroundColorDark,
        secondaryHeaderColor: _primaryColor,
        cardColor: _kSwatch,
        hintColor: Colors.white38,
        disabledColor: _kSwatch[200],
        backgroundColor: _kBackgroundColorDark,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _kBackgroundColorDark,
        // textTheme: _textThemeDark,
        appBarTheme: const AppBarTheme(
          // titleTextStyle: _textThemeDark.headline6,
          // toolbarTextStyle: _textThemeDark.headline6,
          // foregroundColor: _textThemeDark.button?.color,
          elevation: 0.0,
          color: Colors.transparent,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: _kSwatch[900]!,
          disabledColor: _kSwatch,
          selectedColor: _secondaryColor,
          secondarySelectedColor: _secondaryColor,
          padding: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          // labelStyle: _textThemeDark.button!,
          // secondaryLabelStyle: _textThemeDark.button!,
          brightness: Brightness.dark,
        ),
        dividerColor: _kDividerColor,
        iconTheme: const IconThemeData(color: Colors.white),
        // fontFamily: settings.fontName,
      );
}
