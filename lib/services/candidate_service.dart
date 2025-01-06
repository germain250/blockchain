import 'dart:convert';
import 'package:http/http.dart' as http;

class CandidateService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> fetchCandidates() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/candidates'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch candidates');
      }
    } catch (error) {
      print("Error fetching candidates: $error");
      return [];
    }
  }

  static Future<void> castVote(String candidateId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/vote'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'candidateId': candidateId}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to cast vote');
      }
    } catch (error) {
      print("Error casting vote: $error");
    }
  }
}
