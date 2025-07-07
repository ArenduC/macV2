import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/main.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:provider/provider.dart';

appMessagingService(BuildContext context) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  macaPrint('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationHandler.handleMessage(message, context);
  });

  // Listen for messages opened from the background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    NotificationHandler.handleMessage(message, context);
  });
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class NotificationHandler {
  static void handleMessage(RemoteMessage message, BuildContext context) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.themeWhite,
          content: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(11)), color: AppColors.theme),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  color: AppColors.themeLite,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${message.notification!.title}',
                      style: TextStyle(color: AppColors.themeLite, fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    Text(
                      "${message.notification!.body}",
                      style: TextStyle(color: AppColors.themeLite, fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

      final counter = Provider.of<Counter>(context, listen: false);
      if (message.notification != null) {
        macaPrint(message);
        counter.increment();
      }
    }
  }
}
