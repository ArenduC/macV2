// lib/router/router.dart
import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/view/add_electric_bill_view.dart';
import 'package:maca/screen/home_screen.dart';
import 'package:maca/screen/login_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/electricBill':
        return MaterialPageRoute(builder: (_) => const AddElectricBillView());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
