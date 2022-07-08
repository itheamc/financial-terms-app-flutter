import 'package:financial_terms/pages/not_found_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/routes.dart';
import '../../pages/home_page.dart';
import '../../pages/splash_page.dart';

class RoutesHandler {
  ///--------------------------------@mit------------------------------
  /// method to handle onGenerateRoute
  static Route<dynamic> handleOnGenerateRoute(RouteSettings settings) {
    return _getPageRoute(settings);
  }

  ///--------------------------------@mit------------------------------
  /// Method to return GetPageRoute by parsing route
  static Route<dynamic> _getPageRoute(RouteSettings settings) {
    Route<dynamic> pageRoute;

    switch (settings.name) {
      case Routes.splash:
        pageRoute = GetPageRoute(
          page: () => const SplashPage(),
          settings: settings,
          transition: Transition.zoom,
        );
        break;
      case Routes.home:
        pageRoute = GetPageRoute(
          page: () => const HomePage(),
          settings: settings,
          transition: Transition.rightToLeftWithFade,
        );
        break;
      default:
        pageRoute = GetPageRoute(
          page: () => const NotFoundPage(),
          settings: settings,
          transition: Transition.downToUp,
        );
    }
    return pageRoute;
  }

  ///--------------------------------@mit------------------------------
  /// Method to return the get pages
  static List<GetPage<dynamic>> get routePages => [
        GetPage(
          name: Routes.splash,
          page: () => const SplashPage(),
        ),
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
        ),
      ];
}
