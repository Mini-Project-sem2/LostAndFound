import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyNotification {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final _initSettings = InitializationSettings();

  static Future<void> init() async {
    await _notification.initialize(_initSettings,
        onSelectNotification: (payload) async {
      print(payload);
    });
  }

  static Future<void> show(String title, String body) async {
    var _android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannel = NotificationDetails(android: _android);
    await _notification.show(0, title, body, platformChannel);
  }
}
