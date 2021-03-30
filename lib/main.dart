import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationApp(),
    );
  }
}

class NotificationApp extends StatefulWidget {
  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  // 1 - We need to add a package to be able to use local notification
  // 2 - Add Permission to android devices
  // Now Let's create the notification system

  //Local Notification Object
  FlutterLocalNotificationsPlugin localNotifications;

  //Initialize Object
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    //This Function is done to initialize android setting, it takes as a parameter the icon name
    // Make sure that the Icon exist in the drawable folder or it will show an error
    // Then Restart and Run App
    var iOSIntialize = new IOSInitializationSettings();
    var initialzationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSIntialize);
    localNotifications =
        new FlutterLocalNotificationsPlugin(); // Here we instantiate the local notification
    localNotifications.initialize(initialzationSettings);
  }

  //Now it's time for the show notification function
  // First we need to change the type to Future

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "channelID",
        "Local Notification",
        "This is the description of the Notification, you can write anything");
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.show(0, "Flutter Notification",
        "You've been challenged", generalNotificationDetails);
  }

  //Now let's run the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("Click the button to receive a notification"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _showNotification, child: Icon(Icons.notifications)));
  }
}
