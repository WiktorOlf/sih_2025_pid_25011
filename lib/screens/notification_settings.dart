import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
	const NotificationSettingsScreen({super.key});

	@override
	State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
	bool attendanceReminders = true;
	bool announcements = true;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Notification Settings')),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					children: [
						SwitchListTile(
							title: const Text('Attendance reminders'),
							value: attendanceReminders,
							onChanged: (v) => setState(() => attendanceReminders = v),
						),
						SwitchListTile(
							title: const Text('College announcements'),
							value: announcements,
							onChanged: (v) => setState(() => announcements = v),
						),
					],
				),
			),
		);
	}
}

