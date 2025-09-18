import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatefulWidget {
	const ProfileSettingsScreen({super.key});

	@override
	State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
	final TextEditingController nameController = TextEditingController();
	final TextEditingController emailController = TextEditingController();

	bool saving = false;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Profile Settings')),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					children: [
						TextField(
							controller: nameController,
							decoration: const InputDecoration(labelText: 'Name'),
						),
						const SizedBox(height: 12),
						TextField(
							controller: emailController,
							decoration: const InputDecoration(labelText: 'Email'),
						),
						const SizedBox(height: 20),
						SizedBox(
							width: double.infinity,
							child: ElevatedButton(
								onPressed: saving
										? null
										: () async {
									setState(() => saving = true);
									await Future.delayed(const Duration(milliseconds: 600));
									if (mounted) setState(() => saving = false);
									if (mounted) Navigator.pop(context);
								},
								child: const Text('Save'),
							),
						),
					],
				),
			),
		);
	}
}

