import 'package:flutter/material.dart';

class StudentDashboard extends StatefulWidget {
  final String name;
  final String uuid;
  final String email;

  const StudentDashboard({
    super.key,
    required this.name,
    required this.uuid,
    required this.email,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int? selectedPeriod;
  final List<Map<String, dynamic>> periods = [
    {'id': 1, 'status': 'absent'},
    {'id': 2, 'status': 'absent'},
    {'id': 3, 'status': 'present'},
    {'id': 4, 'status': 'unmarked'},
    {'id': 5, 'status': 'unmarked'},
    {'id': 6, 'status': 'unmarked'},
  ];

  final List<Map<String, String>> curriculum = [
    {'subject': 'C++'},
    {'subject': 'COA'},
    {'subject': 'DSC'},
    {'subject': 'English'},
  ];

  void _togglePeriod(int id) {
    setState(() {
      if (selectedPeriod == id) {
        selectedPeriod = null;
      } else if (periods.firstWhere((p) => p['id'] == id)['status'] == 'unmarked') {
        selectedPeriod = id;
      }
    });
  }

  void _markAttendance(int id) {
    setState(() {
      periods.firstWhere((p) => p['id'] == id)['status'] = 'present';
      selectedPeriod = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Attendance marked ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.name),
              accountEmail: Text(widget.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
              ),
              decoration: BoxDecoration(color: Colors.deepPurple),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About the App'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Student Dashboard'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Attendance Periods Section
          Container(
            height: screenHeight * 0.15,
            color: Colors.deepPurple[50],
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: periods.length,
              itemBuilder: (context, index) {
                final period = periods[index];
                Color color;
                if (period['status'] == 'present') {
                  color = Colors.green;
                } else if (period['status'] == 'absent') {
                  color = Colors.red;
                } else {
                  color = Colors.grey;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _togglePeriod(period['id']),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: color,
                          child: Text(
                            'P${period['id']}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (selectedPeriod == period['id'])
                        ElevatedButton(
                          onPressed: () => _markAttendance(period['id']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: const Text('Mark Attendance'),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Divider
          const Divider(thickness: 2),

          // Curriculum Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: curriculum.length,
                itemBuilder: (context, index) {
                  final subject = curriculum[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.deepPurple),
                      title: Text(
                        subject['subject']!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubjectDetailScreen(subject: subject['subject']!),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectDetailScreen extends StatelessWidget {
  final String subject;

  const SubjectDetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> activities = [
      {'title': 'Video 1', 'type': 'Video'},
      {'title': 'Quiz 1', 'type': 'Quiz'},
      {'title': 'Video 2', 'type': 'Video'},
      {'title': 'Quiz 2', 'type': 'Quiz'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: Icon(
                activity['type'] == 'Video' ? Icons.play_circle_fill : Icons.quiz,
                color: Colors.deepPurple,
              ),
              title: Text(activity['title']!),
              subtitle: Text(activity['type']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${activity['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
