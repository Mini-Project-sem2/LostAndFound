import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TrackItNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TrackItNotification() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future showNotification(String category, String subcategory) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'track it',
        playSound: true, importance: Importance.max, priority: Priority.high);
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'item lost',
      'trackit user $subcategory in $category lost near you, /n if found near you ',
      platformChannelSpecifics,
      payload: '',
    );
  }
}
