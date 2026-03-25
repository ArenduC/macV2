import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maca/core/di/service_locator.dart';
import 'package:maca/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:maca/features/admin/presentation/view/screen/admin_screen.dart';

class AdminRootScreen extends StatelessWidget {
  const AdminRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminBloc(getIt(), getIt()),
      child: const AdminScreen(),
    );
  }
}
