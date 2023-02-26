import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  // static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOs = const DarwinInitializationSettings();

    var initializeSettings = InitializationSettings(android: androidInitialize, iOS: iOs);

    await flutterLocalNotificationsPlugin.initialize(initializeSettings, onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {});

  }


  static Future showNotification({
    int id = 1,
    String? title,
    String? body,
    String? payload,
    required FlutterLocalNotificationsPlugin plugin
  })  async {
    var details =  const NotificationDetails(
        android: AndroidNotificationDetails(
            'channel_finki 191291',
            'channel_finki 191291',
            importance: Importance.max,
            // icon: "ic_launcher",
            // channelDescription: 'channel description',
            priority: Priority.high
        ),
      iOS: DarwinNotificationDetails()
    );

    await plugin.show(0, title, body, details);
  }

  static Future showScheduledNotification(int id, String title, String body, FlutterLocalNotificationsPlugin plugin) async {

    var details =  const NotificationDetails(
        android: AndroidNotificationDetails(
            'channel_finki 191291',
            'channel_finki 191291',
            importance: Importance.max,
            // icon: "ic_launcher",
            // channelDescription: 'channel description',
            priority: Priority.high
        ),
        iOS: DarwinNotificationDetails()
    );

    await plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      details,      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,//To show notification even when the app is closed
    );
  }


  // static Future showScheduledNotification({
  //   int id = 1,
  //   String? title,
  //   String? body,
  //   String? payload,
  //   required DateTime scheduledDate,
  //   required FlutterLocalNotificationsPlugin plugin
  // })  async {
  //   var details =  const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //           'channel_finki 191291',
  //           'channel_finki 191291',
  //           importance: Importance.max,
  //           // icon: "ic_launcher",
  //           // channelDescription: 'channel description',
  //           priority: Priority.high
  //       ),
  //       iOS: DarwinNotificationDetails()
  //   );
  //
  //
  //   await plugin.zonedSchedule(0,
  //       "Exam",
  //       "Hey man, don't forget to attend the exam today. Best of luck!",
  //       tz.TZDateTime.now(tz.local).add(Duration(seconds: 1)),
  //
  //   }
}
