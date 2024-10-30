import 'package:flutter/material.dart';

import '../ui/home_page.dart';
import '../widgets/widget_message.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) =>
          const HomePage(),
        );
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