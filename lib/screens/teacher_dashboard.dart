import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TeacherDashboardScreen extends StatefulWidget {
  final String name;
  final String email;
  final int teacherId;

  const TeacherDashboardScreen({
    super.key,
    required this.name,
    required this.email,
    required this.teacherId,
  });

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  bool _periodActive = false;
  int? _periodId;
  final ApiService _api = ApiService();

  Future<void> startPeriod() async {
    try {
      // For now we use a placeholder period name. You can make this dynamic.
      final res = await _api.startPeriod(periodName: 'Lecture', teacherId: widget.teacherId);
      setState(() {
        _periodActive = true;
        _periodId = (res['period_id'] as num).toInt();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Period started ✅')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to start period')),
      );
    }
  }

  Future<void> stopPeriod() async {
    try {
      if (_periodId == null) throw Exception('No active period');
      await _api.stopPeriod(periodId: _periodId!);
      setState(() {
        _periodActive = false;
        _periodId = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Period stopped ✅')),
      );
    } catch (e) {
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
