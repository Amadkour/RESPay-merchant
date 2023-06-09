import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  NotificationService(this._localNotificationsPlugin);

  Future<void> initNotificationService() async {
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    getDeviceToken().then((String value) {
      if (type == 'test') {
        log('device_token:$value');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await sendLocalMessage(message, message.data['payload'] as String?);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      final String? json = event.data['payload'] as String?;
      _mapPayload(json);
    });

    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        "app_logo",
      ),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );
  }

  void _mapPayload(String? payload) {}

  Future<void> sendLocalMessage(RemoteMessage? notification, String? payload) async {
    await _localNotificationsPlugin.show(
      notification.hashCode,
      notification?.notification?.title ?? notification?.data['title'] as String?,
      notification?.notification?.body ?? notification?.data['body'] as String?,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "com.Res.pay.sa.res_pay",
          "Res Pay",
          icon: 'app_logo',
        ),
      ),
      payload: payload,
    );
  }

  Future<String> getDeviceToken() async {
    return (await FirebaseMessaging.instance.getToken()) ?? "";
  }
}
