import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:one/models/prayer.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  Future<List<Prayer>> getPrayers(int userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/get-prayers?user_id=$userId'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Prayer.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load prayers');
    }
  }

  Future<void> savePrayer(int userId, int prayerId, bool status) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save-prayer'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'prayer_id': prayerId,
        'status': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save prayer status');
    }
  }
}
