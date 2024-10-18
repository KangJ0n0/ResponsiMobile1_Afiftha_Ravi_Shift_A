import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://103.196.155.42/api';

  // Fetch all Ulasan
  Future<List<dynamic>> fetchUlasan() async {
    final response = await http.get(Uri.parse('$baseUrl/pariwisata/ulasan'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load ulasan');
    }
  }

  // Create Ulasan
  Future<void> createUlasan(String reviewer, int rating, String comments) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pariwisata/ulasan'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'reviewer': reviewer, 'rating': rating, 'comments': comments}),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create ulasan');
    }
  }

  // Update Ulasan
  Future<void> updateUlasan(int id, String reviewer, int rating, String comments) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pariwisata/ulasan/$id/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'reviewer': reviewer, 'rating': rating, 'comments': comments}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update ulasan');
    }
  }

  // Delete Ulasan
  Future<void> deleteUlasan(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pariwisata/ulasan/$id/delete'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete ulasan');
    }
  }
}
