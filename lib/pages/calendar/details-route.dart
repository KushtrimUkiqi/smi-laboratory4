import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lab4_test/api/notifications.dart';
import 'package:lab4_test/components/bottom-bar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../components/drawer.dart';

final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

class DetailsRoute extends StatefulWidget {
  Appointment? appointment;

  DetailsRoute({this.appointment});

  @override
  State<DetailsRoute> createState() => _DetailsRouteState();
}

class _DetailsRouteState extends State<DetailsRoute> {
// final notificationsApi = NotificationApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeNoti();
  }

  void initializeNoti() {
    NotificationApi.initialize(_notifications);
  }

  void notify () async {
    // NotificationApi.showNotification(
    //     title: "hello world",
    //     body: "proof of concept for notifications",
    //     payload: "191291",
    //     plugin:  _notifications
    // );


    NotificationApi.showScheduledNotification(0,"Hi mate","Here a notificaton for you",_notifications);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Divider(color: Colors.white,),
          Center(
            child: Text(
              widget.appointment!.subject,
            ),
          ),
          Divider(color: Colors.white,),
          Center(
            child: Text(
                DateFormat('MMMM yyyy,hh:mm a').format(widget.appointment!.startTime,).toString()),
          ),
          Divider(color: Colors.white,),
          Center(
            child: Text(
                DateFormat('MMMM yyyy,hh:mm a').format(widget.appointment!.endTime,).toString()),
          ),
          ElevatedButton(onPressed: () {
            notify();
          }, child: Text("Notify me! for 10 seconds"))
        ],
      ),
    );
  }
}