import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('icon');

  void initialiseNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title,String body)async{
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channelId', 
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0, 
      title, 
      body, 
      notificationDetails
    );
  }

  void secheduleNotification(String title,String body)async{
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channelId', 
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0, 
      title, 
      body, 
      RepeatInterval.everyMinute, 
      notificationDetails,
    );
  }

  void stopNotification()async{
    _flutterLocalNotificationsPlugin.cancel(0);
  }

}