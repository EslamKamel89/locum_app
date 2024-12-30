import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/heleprs/snackbar.dart';

Future<void> requestFirebaseNotificationsPermission() async {
  final t = prt('Firebase notification rerquest permission');
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    pr('User granted permission', t);
  } else {
    pr('User declined or has not accepted permission', t);
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    showSnackbar('Warning', "You didn't give the app notification permission", true);
  }
}
