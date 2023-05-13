import 'package:flutter/material.dart';
import 'package:meminder/app/widgets/route_not_found_screen.dart';
import 'package:meminder/features/meme/screens/meme_home_page.dart';
import 'package:meminder/features/settings/screens/setting_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case MemeHomePage.pageUrl:
        return MaterialPageRoute(
          builder: (context) => const MemeHomePage(),
        );
      case SettingScreen.pageUrl:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const RouteNotFoundScreen(),
        );
    }
  }
}
