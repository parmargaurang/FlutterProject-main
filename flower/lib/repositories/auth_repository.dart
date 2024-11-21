import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'https://4b999a03-18fc-4700-a1d2-372cdf4bd654.mock.pstmn.io';

  // Function to log in a user
  Future<String> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    // Sending POST request to login endpoint
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['token']; // Assuming the response has a token
    } else {
      throw Exception('Login failed');
    }
  }

  // Function to register a user (as before)
  Future<void> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Registration failed');
    }
  }
}
