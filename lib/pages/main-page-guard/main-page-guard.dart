import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab4_test/pages/calendar/calendar.dart';
import 'package:lab4_test/pages/home/home-screen.dart';
import 'package:lab4_test/pages/login/login.dart';
import 'package:lab4_test/statics/routes.dart';

class GuardMainPage extends StatelessWidget {
  final String route;

  const GuardMainPage({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            switch(route)
            {
              case Routes.calendar : {
                return CalendarPage();
              }
              case Routes.login : {
                return LoginPage();
              }
              default : {
                return HomePage();
              }
            }

          }
          else {
            return LoginPage();
          }
        }
      )
    );
  }
}
