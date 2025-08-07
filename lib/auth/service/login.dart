import 'package:flutter/material.dart';
import 'package:maca/auth/model/login_request.dart';
import 'package:maca/auth/model/login_response.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/screen/home_screen.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';

Future<void> handleLoginRequest(BuildContext context, String username, String password, String fcmToken) async {
  final loginRequest = LoginRequest(
    email: username,
    password: password,
    accessToken: fcmToken,
  );

  macaPrint(loginRequest.toJson());

  final response = await ApiService().apiCallService(
    endpoint: PostUrl().userLogin,
    method: "POST",
    body: loginRequest.toJson(),
  );

  final loginResponse = LoginResponse.fromJson(AppFunction().macaApiResponsePrintAndGet(data: response));

  if (loginResponse.isSuccess) {
    final userData = loginResponse.data.first;

    LocalStore().setStore(ListOfStoreKey.loginDetails, userData.toJson());
    LocalStore().setStore(ListOfStoreKey.loginStatus, true);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
