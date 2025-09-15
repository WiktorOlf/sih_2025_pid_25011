import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.0.70:5000"; // Your local server IP

  Future<bool> markAttendance(String uuid) async {
    final url = Uri.parse('$baseUrl/mark_attendance');
    final response = await http.post(url, body: {'uuid': uuid});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> getAttendanceReport() async {
    final url = Uri.parse('$baseUrl/attendance_report');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch report");
    }
  }
}
