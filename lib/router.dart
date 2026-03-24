// lib/router/router.dart
import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/view/add_electric_bill_view.dart';
import 'package:maca/features/admin/presentation/view/admin_root_screen.dart';
import 'package:maca/features/expenditure/view/expenditure_add_view.dart';
import 'package:maca/screen/home_screen.dart';
import 'package:maca/auth/view/login_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/electricBill':
        return MaterialPageRoute(builder: (_) => const AddElectricBillView());
      case '/expenditure':
        return MaterialPageRoute(builder: (_) => const ExpenditureAddView());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/admin':
        return MaterialPageRoute(builder: (_) => const AdminRootScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
