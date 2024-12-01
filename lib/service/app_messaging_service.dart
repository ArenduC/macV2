import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/main.dart';
import 'package:maca/provider/notification_provider.dart';
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

void _handleMessage(RemoteMessage message, BuildContext context) {
  if (!context.mounted) {
    macaPrint("Context is no longer mounted, skipping...");
    return;
  }

  // Access the provider
  final counter = Provider.of<Counter>(context, listen: false);

  if (message.notification != null) {
    macaPrint(message);

    // Increment the counter (this automatically notifies listeners)
    counter.increment();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationHandler {
  static void handleMessage(RemoteMessage message, BuildContext context) {
    macaPrint(message);
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Notification: ${message.notification!.title}\n${message.notification!.body}'),
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
