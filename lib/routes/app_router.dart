// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/appointments_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/splash_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String appointments = '/appointments';
  static const String booking = '/booking';
  static const String splash = '/splash';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
