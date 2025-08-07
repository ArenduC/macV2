// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maca/auth/service/get_bed_available.dart';
import 'package:maca/auth/service/login.dart';
import 'package:maca/auth/view/login_segment.dart';
import 'package:maca/auth/view/registration_segment.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/helper/registration_validation_helper.dart';
import 'package:maca/screen/home_screen.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //For keyboard focusNode
  final FocusNode focusNode = FocusNode();

  //For controller
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bedNoController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  //For bool variable
  bool isLoginPage = true;
  bool isKeyboardActive = false;

  //For string variable
  String? bedNo = "";

  //For dynamic variable
  dynamic occupiedBedList = [];
  dynamic availableBet = [];
  dynamic fcmToken;
  dynamic bedActive = {
    "user_bed": null,
    "id": null,
  };

  @override
  void initState() {
    super.initState();
    // Add a listener to the focus node
    getFcmToken();
    getBedAvailable();
    focusNode.addListener(() {
      setState(() {
        isKeyboardActive = focusNode.hasFocus;
      });
    });
  }

  getFcmToken() async {
    String getFcmTokenFromLocal = await getLocalStorageData(ListOfStoreKey.fcmToken);
    setState(() {
      fcmToken = getFcmTokenFromLocal.toString();
    });
    macaPrint(fcmToken, "loginFcm");
  }

  handleLogin(String username, String password) async {
    await handleLoginRequest(context, username, password, fcmToken);
  }

  void handleRegistration(dynamic data) async {
    if (!validateInput(context, data)) return;
    dynamic jsonBody = {
      "user_name": data["userName"],
      "user_email": data["email"],
      "user_bed": data["bedNo"],
      "user_phone_no": data["phoneNo"],
      "user_password": data["password"],
    };
    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().userRegistration, method: ApiType().post, body: jsonBody);
    occupiedBedList = AppFunction().macaApiResponsePrintAndGet(data: response);
    if (occupiedBedList["isSuccess"] == true) {
      setState(() {
        isLoginPage = true;
      });
    }
  }

  void bedSelectHandle(dynamic selectedBedNo) {
    setState(() {
      bedNo = selectedBedNo["user_bed"];
      bedActive = selectedBedNo;
    });
  }

  void pageSwitch() {
    availableBet = getBedAvailable();
    setState(() {
      print("button click");
      isLoginPage = !isLoginPage;
    });
  }

  //For keyboard detection
  bool get isKeyboardOpen {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  @override
  void dispose() {
    focusNode.dispose(); // Clean up the focus node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none, // Allow the circle to overflow
          children: [
            Positioned(
                top: 40,
                left: 20,
                right: 0,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Welcome to",
                    style: AppTextStyles.headline2,
                  ),
                  SvgPicture.asset(
                    'assets/APPSVGICON/maca.svg',
                    width: 50,
                    height: 50,
                  ),
                ])),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500), // Animation duration
              curve: Curves.easeInOut,
              top: isLoginPage
                  ? isKeyboardOpen
                      ? 0
                      : 500
                  : isKeyboardOpen
                      ? 0
                      : 300, // Adjust to position the circle as needed
              left: -150, // Adjust to position the circle as needed
              child: Container(
                width: MediaQuery.of(context).size.width * 2, // Make it large enough to overflow
                height: MediaQuery.of(context).size.height * 2, // Same for height
                decoration: BoxDecoration(
                  borderRadius: isKeyboardOpen ? BorderRadius.circular(0) : BorderRadius.circular(500),
                  color: AppColors.theme,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation, // Fade effect
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0), // Slide in from the right
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: isLoginPage
                    ? KeyedSubtree(key: const ValueKey('login'), child: loginSegment(pageSwitch, emailController, passwordController, focusNode, handleLogin))
                    : KeyedSubtree(
                        key: const ValueKey('register'),
                        child: registrationSegment(context, pageSwitch, bedActive, availableBet, emailController, passwordController, userNameController, bedNoController, phoneNoController,
                            bedSelectHandle, handleRegistration)),
              ),
            )
            // Add other widgets here as needed
          ],
        ),
      ),
    );
  }
}
