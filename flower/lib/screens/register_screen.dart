import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http for API calls
import 'package:flower/screens/home_screen1.dart';
import 'dart:convert'; // For encoding/decoding JSON
import 'home_screen.dart'; // Your Home Screen
import 'login_screen.dart'; // Your Login Screen
import 'AppColor.dart'; // Your color scheme

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false; // Loading state

  // Function to send a POST request to register the user
  Future<void> _registerUser(String Name, String email, String password) async {
    final url = 'http://192.168.63.155:3000/register'; // Replace with your API URL

    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': Name,
          'email': email,
          'password': password,
        }),
      );

      setState(() {
        _isLoading = false; // Set loading state to false after request
      });

      if (response.statusCode == 200) {
        // If registration is successful, navigate to the HomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen1()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.body}')),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false; // Ensure loading state is false on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  void _onRegisterPressed() {
    final email = _emailController.text;
    final Name = _fullNameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty || email.isEmpty || Name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
      return;
    }

    if (password == confirmPassword) {
      _registerUser(Name, email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              physics: BouncingScrollPhysics(),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    margin: EdgeInsets.only(bottom: 20),
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                // Header
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                // Form Fields
                _buildTextField('Full Name', 'Your Full Name', _fullNameController),
                _buildTextField('Email', 'youremail@email.com', _emailController),
                _buildTextField('Password', '**********', _passwordController, obscureText: true),
                _buildTextField('Retype Password', '**********', _confirmPasswordController, obscureText: true),
                // Register Button
                Container(
                  margin: EdgeInsets.only(top: 32, bottom: 6),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onRegisterPressed, // Disable button during loading
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white) // Show loading indicator
                        : Text(
                      'Register',
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColor.primarySoft,
                    ),
                  ),
                ),
                // Login Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                          text: 'Log in',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String title, String hint, TextEditingController controller, {bool obscureText = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
