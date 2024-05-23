import 'package:dog_picture/app/pages/home/ui/home_ui.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

mixin RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Map<String, dynamic>? args =
    //     settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.index:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomeUI(),
        );

      default:
        return _route404();
    }
  }

  static Route<dynamic> _route404() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}
