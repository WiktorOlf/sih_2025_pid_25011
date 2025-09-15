import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/student_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
      routes: {
        '/dashboard': (context) => const StudentDashboard(
              name: 'Dummy',
              uuid: 'uuid1',
              email: 'dummy@student.com',
            ),
      },
    );
  }
}
