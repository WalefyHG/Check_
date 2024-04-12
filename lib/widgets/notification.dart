import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class NotificationHelper{
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print(response);
      }
    );

  }

  static Future<void> requestNotificationPermission() async{
    PermissionStatus status = await Permission.notification.status;

    if(status.isDenied){
      status = await Permission.notification.request();
    }
    if(status.isGranted){
      await init();
    }else{
      await requestNotificationPermission();
    }
  }

  static Future<void> scheduledNotification(int alarmId, String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'Check',
      'Checando as Informações',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await _notification.show(
        alarmId,
        title,
        body,
        notificationDetails,
    );
  }

}