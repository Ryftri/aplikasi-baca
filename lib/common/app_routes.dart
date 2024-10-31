import 'package:aplikasi_baca/common/route_transition.dart';
import 'package:flutter/material.dart';

import '../ui/home_page.dart';
import '../ui/login_page.dart';
import '../ui/regristation_page.dart';
import '../widgets/widget_message.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return RouteTransitions.buildPageRoute(const HomePage());
      case RegistrationPage.routeName:
        return RouteTransitions.buildPageRoute(const RegistrationPage());
      case LoginPage.routeName:
        return RouteTransitions.buildPageRoute(const LoginPage());
      default :
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const Scaffold(
            body: WidgetMessage(message: 'Notfound'),
          ),
        );
    }
  }
}