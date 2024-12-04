import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:maca/function/app_function.dart';
import 'package:maca/provider/notification_provider.dart';

import 'package:maca/screen/start_up_screen.dart';
import 'package:maca/store/local_store.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures proper binding before initialization.
  await Firebase.initializeApp();
  dynamic fcmToken = await FirebaseMessaging.instance.getToken();
  LocalStore().setStore(ListOfStoreKey.fcmToken, fcmToken.toString());
  macaPrint(fcmToken, "fcmToken");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider<Counter>(
          create: (context) => Counter(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'maca',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const StartUpScreen(),
    );
  }
}
