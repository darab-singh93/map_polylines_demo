import 'package:fictive_box_task/views/pages/show_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/pages/home.dart';

class RoutePath {
  static const String home = "/home";
  static const String showRoute = "/showRoute";
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return CupertinoPageRoute(builder: (ctx) => const Home());
      case RoutePath.showRoute:
        final args = settings.arguments as ShowRoute;
        return CupertinoPageRoute(
            builder: (ctx) => ShowRoute(
                  source: args.source,
                  destination: args.destination,
                ),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
