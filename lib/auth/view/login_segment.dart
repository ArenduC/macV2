import 'package:flutter/material.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

@override
Widget loginSegment(
  VoidCallback pageSwitch,
  TextEditingController emailController,
  TextEditingController passwordController,
  FocusNode focusNode,
  Function(String username, String password) handleLogin,
) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Login",
              style: AppTextStyles.headline1,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: emailController,
          decoration: AppInputStyles.textFieldDecoration(
            hintText: 'Enter your email',
            prefixIcon: Icons.person,
          ),
          style: TextStyle(color: AppColors.header1), // Text style
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: AppInputStyles.textFieldDecoration(
            hintText: 'Enter your password',
            prefixIcon: Icons.password,
          ),
          style: TextStyle(color: AppColors.header1), // Text style
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () {
            String username = emailController.text;
            String password = passwordController.text;

            // Pass data to the parent widget's callback
            handleLogin(username, password);
          },
          style: AppButtonStyles.elevatedButtonStyle(),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    ),
  );
}
