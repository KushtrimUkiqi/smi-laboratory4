import 'package:flutter/material.dart';
import 'package:lab4_test/components/bottom-bar.dart';
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
          allowedViews: [CalendarView.month, CalendarView.week, CalendarView.day],
        ),
      ),
    );
  }
}