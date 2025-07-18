// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Future<dynamic> handleLogin(String username, String password) async {
    dynamic jsonObject = {"email": username, "password": password, "accessToken": fcmToken};
    macaPrint(jsonObject);
    dynamic loginData;
    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().userLogin, method: "POST", body: jsonObject);
    loginData = AppFunction().macaApiResponsePrintAndGet(data: response);

    if (loginData["isSuccess"] == true) {
      AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data");
      LocalStore().setStore(ListOfStoreKey.loginDetails, AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data"));
      LocalStore().setStore(ListOfStoreKey.loginStatus, loginData["isSuccess"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
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
    macaPrint(selectedBedNo);
    setState(() {
      bedNo = selectedBedNo["user_bed"];
      bedActive = selectedBedNo;
    });
    macaPrint(bedActive["user_bed"]);
  }

  void pageSwitch() {
    getBedAvailable();
    setState(() {
      print("button click");
      isLoginPage = !isLoginPage;
    });
  }

  //For keyboard detection
  bool get isKeyboardOpen {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  Future<dynamic> getBedAvailable() async {
    dynamic response = await ApiService().apiCallService(endpoint: GetUrl().bedList, method: "GET");
    occupiedBedList = AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data");
    availableBet = AppFunction().createBedStatusList(occupiedBedList, Appdata().allBeds);
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
            print("Login button pressed");
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text(
        //       "Don’t have account ?",
        //       style: AppTextStyles.linkText,
        //     ),
        //     GestureDetector(
        //       onTap: () {
        //         pageSwitch();
        //       },
        //       child: const Text(
        //         "Register here",
        //         style: AppTextStyles.bodyText,
        //       ),
        //     )
        //   ],
        // )
      ],
    ),
  );
}

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
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          width: double.infinity,
          height: (MediaQuery.of(context).size.height - 64) / 3,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.2,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(color: AppColors.textHint, borderRadius: const BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/APPSVGICON/bed.svg',
                          width: 12,
                          height: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Bed available",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.theme),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        circularIndicator("Idle", AppColors.themeWhite),
                        const SizedBox(
                          width: 10,
                        ),
                        circularIndicator("Occupied", AppColors.textHint),
                      ],
                    )
                  ],
                ),
              ),
              Wrap(
                spacing: 16.0, // Space between items horizontally
                runSpacing: 16.0, // Space between rows
                children: bedNumbers.map<Widget>((bed) {
                  return GestureDetector(
                    onTap: () {
                      if (!bed["is_active"]) {
                        bedSelectHandle(bed);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 64) / 5, // 3 items per row
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: bed["is_active"]
                            ? AppColors.themeLite
                            : bed["user_bed"] == bedNo["user_bed"]
                                ? AppColors.theme
                                : AppColors.themeWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(83, 37, 37, 37),
                            blurRadius: 10, // Spread of the blur
                            offset: Offset(0, 4), // Horizontal and vertical offset
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            bed["user_bed"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: bed["is_active"]
                                  ? AppColors.themeWhite
                                  : bed["user_bed"] != bedNo["user_bed"]
                                      ? AppColors.theme
                                      : AppColors.themeWhite,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
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
