
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/utils/notifications.dart';

class FirebaseMessagingService {
  final LocalNotificationHelper _notificationHelper = LocalNotificationHelper();

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true
    );

    _onMessage();

  }
  
  Future<String?> getDeviceFirebaseToken() async{
    final String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('Token: $token');
    return token;
  }
  
  _onMessage() {
    FirebaseMessaging.onMessage.listen((message){
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if(notification != null && android != null){
        _notificationHelper.showNotification(notification.title!, notification.body!);
      }
    });
  }
}