import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab4_test/components/bottom-bar.dart';
import 'package:lab4_test/dtos/examDto.dart';
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
  List<ExamDto> examDtos = [];

  getData() async {
    // List<List<ExamDto>> examSnapshots;
    //
    // examSnapshots = await FirebaseFirestore.instance
    //     .collection("events")
    //     .snapshots()
    //     .map((snapshot) => snapshot.docs.map((e) =>
    //     ExamDto.fromJson(e.data(), "")
    // ).toList()).toList();
    //
    // setState(() {
    //   examDtos = examSnapshots;
    // });
    // var a = examSnapshots;

    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection('events');

    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    var allData = querySnapshot.docs.map((doc) => ExamDto.fromJson(doc.data() as Map<String, dynamic>)).toList();

    var currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    setState(() {
      examDtos = allData.where((element) => element.userEmail == currentUserEmail).toList();
    });
  }

  @override
  void initState(){
    super.initState();

    getData();
  }

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
          dataSource: _getCalendarDataSource(examDtos),
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

_AppointmentDataSource _getCalendarDataSource(List<ExamDto> exams) {



  // appointments.add(Appointment(
  //   startTime: DateTime.now(),
  //   endTime: DateTime.now().add(Duration(hours: 3)),
  //   subject: 'Meeting',
  //   color: Colors.indigo,
  //   startTimeZone: '',
  //   endTimeZone: '',
  // ));

  List<Appointment> appointments = exams.map((e) => Appointment(
      startTime: DateTime(e.date.year, e.date.month, e.date.day, e.time.hour, e.time.minute),
      endTime: DateTime(e.date.year, e.date.month, e.date.day, e.time.hour, e.time.minute).add(Duration(hours: 3)),
      subject: e.subject,
      color: Colors.indigo,
      startTimeZone: '',
      endTimeZone: '',
    )
  ).toList();

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
    appointments = source;
  }
}