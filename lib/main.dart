import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/day_view_screen.dart';
import 'screens/month_calendar_screen.dart';
import 'services/firebase_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  await NotificationService.init();
  await FirebaseService.signInAnonymously();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Calendar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          DayViewScreen(),
          HomeScreen(),
          MonthCalendarScreen(),
        ],
      ),
    );
  }
}