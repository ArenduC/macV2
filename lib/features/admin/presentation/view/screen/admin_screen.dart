import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maca/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:maca/styles/colors/app_colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AdminBloc>().add(LoadUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.theme,
                )),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Admin Control",
              style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
        if (state is AdminInitial) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.theme,
          ));
        }

        if (state is AdminLoaded) {
          return ListView.builder(
              itemCount: state.allUserDetails.length,
              itemBuilder: (context, index) {
                final user = state.allUserDetails[index];
                return ListTile(
                  title: GestureDetector(onTap: () => context.read<AdminBloc>().add(UserStatusUpdate(user.userId, 1, 1, "1")), child: Text(user.name)),
                );
              });
        }

        if (state is AdminFailed) {
          return const Center(
            child: Text("Failed to Fetched"),
          );
        }

        return const SizedBox();
      }),
    );
  }
}
