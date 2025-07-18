import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/router.dart';
import 'package:maca/screen/start_up_screen.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures proper binding before initialization.
  await Firebase.initializeApp();
  dynamic fcmToken = await FirebaseMessaging.instance.getToken();
  LocalStore().setStore(ListOfStoreKey.fcmToken, fcmToken.toString());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider<Counter>(
          create: (context) => Counter(),
        ),
        ChangeNotifierProvider<WidgetUpdate>(
          create: (context) => WidgetUpdate(),
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
      title: 'Maca',
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.theme),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const StartUpScreen(),
    );
  }
}
