import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /// Initialize awesome notifications
  AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic notifications',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );

  await requestNotificationPermission();
  runApp(const MyApp());
}
Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}