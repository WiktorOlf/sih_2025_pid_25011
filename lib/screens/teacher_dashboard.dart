import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherDashboardScreen extends StatefulWidget {
  final String name;
  final String email;

  const TeacherDashboardScreen({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  bool _periodActive = false;

  Future<void> startPeriod() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/period/start'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _periodActive = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Period started ✅')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to start period')),
      );
    }
  }

  Future<void> stopPeriod() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/period/stop'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _periodActive = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Period stopped ✅')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to stop period')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome, ${widget.name}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _periodActive ? 'Period is ACTIVE' : 'No active period',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _periodActive ? stopPeriod : startPeriod,
              child: Text(_periodActive ? 'Stop Period' : 'Start Period'),
            ),
          ],
        ),
      ),
    );
  }
}
