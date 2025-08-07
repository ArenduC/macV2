import 'package:flutter/material.dart';
import 'package:maca/auth/view/available_bed_details.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

@override
Widget registrationSegment(
    BuildContext context,
    VoidCallback pageSwitch,
    dynamic bedNo,
    dynamic bedNumbers,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController userNameController,
    TextEditingController bedNoController,
    TextEditingController phoneNoController,
    Function(
      dynamic selectedBedNo,
    ) bedSelectHandle,
    Function(dynamic data) handleRegistration) {
  Widget circularIndicator(
    dynamic title,
    Color indicatorColor,
  ) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: indicatorColor, borderRadius: const BorderRadius.all(Radius.circular(30)), boxShadow: const [AppBoxShadow.defaultBoxShadow]),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: AppTextStyles.indicatorTextStyle,
        )
      ],
    );
  }

  void showBedSelectionModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      isScrollControlled: true, // Allows the modal to take more space
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Optional rounded corners
      ),
      builder: (context) {
        return availableBedDetails(bedNo, bedNumbers, circularIndicator, bedSelectHandle);
      },
    );
  }

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
              "Registration",
              style: AppTextStyles.headline1,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: userNameController,
          decoration: AppInputStyles.textFieldDecoration(
            hintText: 'Enter your username',
            prefixIcon: Icons.person,
          ),
          style: TextStyle(color: AppColors.header1), // Text style
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: emailController,
          decoration: AppInputStyles.textFieldDecoration(
            hintText: 'Enter email',
            prefixIcon: Icons.email,
          ),
          style: TextStyle(color: AppColors.header1), // Text style
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: showBedSelectionModal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bed,
                      color: AppColors.themeLite,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      bedNo["user_bed"] ?? 'Enter bed no',
                      style: TextStyle(
                        color: bedNo["user_bed"] == null ? Colors.grey : AppColors.header1, // Replace with your color
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_downward,
                  color: AppColors.themeLite,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: phoneNoController,
          decoration: AppInputStyles.textFieldDecoration(
            hintText: 'Phone no',
            prefixIcon: Icons.phone_android,
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
            dynamic regJson = {"userName": userNameController.text, "email": emailController.text, "bedNo": bedNo["id"], "phoneNo": phoneNoController.text, "password": passwordController.text};
            // Add your button's functionality here
            handleRegistration(regJson);
          },
          style: AppButtonStyles.elevatedButtonStyle(),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Have an account ?",
              style: AppTextStyles.linkText,
            ),
            GestureDetector(
              onTap: () {
                pageSwitch();
              },
              child: Text(
                "Login here",
                style: AppTextStyles.bodyText,
              ),
            )
          ],
        )
      ],
    ),
  );
}
