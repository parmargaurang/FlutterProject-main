import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserListScreen extends StatelessWidget {
  Future<List<Map<String, String>>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://192.168.63.155:3000/userlist'));
    if (response.statusCode == 200) {
      // Parse the API response
      List<dynamic> data = json.decode(response.body);
      // Ensure proper casting and type safety
      return data.map((user) => {
        'name': user['name'].toString(),   // Convert to String
        'email': user['email'].toString(), // Convert to String
      }).toList().cast<Map<String, String>>();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Text(
                          users[index]['name']!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          users[index]['email']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserListScreen(),
  ));
}
