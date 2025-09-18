import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // For Android emulator use 10.0.2.2 to reach host; adjust for device/Wi‑Fi
  final String baseUrl = "http://10.0.2.2:8000";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('Login failed: ${response.body}');
  }

  Future<Map<String, dynamic>> startPeriod({required String periodName, required int teacherId}) async {
    final url = Uri.parse('$baseUrl/period/start');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'period_name': periodName,
        'teacher_id': teacherId,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('Start period failed: ${response.body}');
  }

  Future<void> stopPeriod({required int periodId}) async {
    final url = Uri.parse('$baseUrl/teacher/period/stop');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'period_id': periodId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Stop period failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> markAttendance({required String studentUuid}) async {
    final url = Uri.parse('$baseUrl/attendance/mark');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'student_uuid': studentUuid,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('Mark attendance failed: ${response.body}');
  }
}
