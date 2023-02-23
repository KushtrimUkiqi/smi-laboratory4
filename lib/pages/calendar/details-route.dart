import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab4_test/components/bottom-bar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../components/drawer.dart';

class DetailsRoute extends StatelessWidget {
  Appointment? appointment;

  DetailsRoute({this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Divider(color: Colors.white,),
          Center(
            child: Text(
              appointment!.subject,
            ),
          ),
          Divider(color: Colors.white,),
          Center(
            child: Text(
                DateFormat('MMMM yyyy,hh:mm a').format(appointment!.startTime,).toString()),
          ),
          Divider(color: Colors.white,),
          Center(
            child: Text(
                DateFormat('MMMM yyyy,hh:mm a').format(appointment!.endTime,).toString()),
          ),
        ],
      ),
    );
  }
}