

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;

class NotificationControl {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void requestPermission() async {
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

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  void storeToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection("patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"fcmToken": fcmToken});
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
    
  }

  void sendPushMessage(String body, String title, String fcmToken) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAqdGrDb4:APA91bFh2FNgPJ6Msk2INB0M-gyVXE8ooxGjPIkjxQMIjEpsd65yG_Jvu1Pu1Wx8j2j0eN73HTUW-tbPuupIx9nfAYBxNx-EZjwtYMzPc-H7Nex3o5Fb4OO8wtjA-D9cIdcak5ooLquc',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'screen': 'screen2'
            },
            "to": fcmToken,
          },
        ),
      );
    } catch (e) {
      debugPrint("error push notification");
    }
  }
  
  void sendChatPushMessage(String body, String title, String fcmToken) async {
    debugPrint("111 fcm TOken $fcmToken body $body title $title");
    try {
       final FirebaseAuth _auth = FirebaseAuth.instance;
             User currentUse = _auth.currentUser!;
           final uId =   currentUse.uid;
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAqdGrDb4:APA91bFh2FNgPJ6Msk2INB0M-gyVXE8ooxGjPIkjxQMIjEpsd65yG_Jvu1Pu1Wx8j2j0eN73HTUW-tbPuupIx9nfAYBxNx-EZjwtYMzPc-H7Nex3o5Fb4OO8wtjA-D9cIdcak5ooLquc',
        },
        body: jsonEncode(
          <String, dynamic>{
           
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'patientId': uId,
              'screen':'chatScreen',
            },
            "to": fcmToken,
          },
        ),
      );

    } catch (e) {
      debugPrint("error push notification $e");
    }
  }
  
}
