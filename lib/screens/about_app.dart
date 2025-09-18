import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
	const AboutAppScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('About the App')),
			body: const Padding(
				padding: EdgeInsets.all(16),
				child: Text(
					'Smart Attendance System for Colleges\n\n'
					'Automates attendance using UUID and Face Recognition.\n'
					'Built for Smart India Hackathon 2025.',
				),
			),
		);
	}
}

