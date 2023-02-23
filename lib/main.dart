import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_test/blocks/user/user_bloc.dart';
import 'package:lab4_test/pages/login/login.dart';
import 'package:lab4_test/pages/main-page-guard/main-page-guard.dart';
import './pages/calendar/calendar.dart';
import './pages/home/home-screen.dart';
import './statics/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()..add(InitializeUserEvent()))
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: Routes.home,
        routes: {
          // Routes.guard: (context) => GuardMainPage(route: Routes.home),
          // Routes.home: (context) => const HomePage(),
          // Routes.calendar: (context) => const CalendarPage(),
          // Routes.login: (context) => const LoginPage(),
          Routes.home: (context) => const GuardMainPage(route: Routes.home),
          Routes.calendar: (context) => const GuardMainPage(route: Routes.calendar),
          Routes.login: (context) => const GuardMainPage(route: Routes.login),
        },
      ),
    );
  }
}