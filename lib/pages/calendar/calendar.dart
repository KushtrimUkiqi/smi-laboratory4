import 'package:flutter/material.dart';
import 'package:lab4_test/components/bottom-bar.dart';
import 'package:lab4_test/pages/calendar/details-route.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../components/drawer.dart';

enum ItemType { itemOne, itemTwo, itemThree }


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  ItemType? selectedMenu;

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Appointment appointment = calendarTapDetails.appointments![0];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsRoute(appointment:appointment)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBarComponent(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const DrawerComponent(),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          onTap: calendarTapped,
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          dataSource: _getCalendarDataSource(),
          allowedViews: [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth,
            CalendarView.schedule
          ],
        ),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 3)),
    subject: 'Meeting',
    color: Colors.indigo,
    startTimeZone: '',
    endTimeZone: '',
  ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
    appointments = source;
  }
}