import 'package:flutter/material.dart';
import 'package:watchdog/constants/api.dart';
import 'package:watchdog/pages/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String authURL = '$api/api-auth/login/';
  String _csrfToken = '';

  @override
  void initState() {
    super.initState();
    _fetchCsrfToken();
  }

  Future<void> _fetchCsrfToken() async {
    try {
      final response = await http.get(
        Uri.parse(authURL), // Adjust the URL as needed
      );
      if (response.statusCode == 200) {
        // Extract CSRF token from the response
        setState(() {
          _csrfToken = response.headers['csrf-token'] ?? '';
        });
      } else {
        throw Exception('Failed to fetch CSRF token');
      }
    } catch (e) {
      print('Error fetching CSRF token: $e');
    }
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final response = await http.post(
      Uri.parse(authURL),
      headers: <String, String>{
        'Authorization':'Bearer ${base64Encode(utf8.encode('$username:$password'))}',
        'Content-Type': 'application/json',
        'X-CSRFToken': _csrfToken, // Include CSRF token in the headers
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _csrfToken = response.headers['csrf-token'] ?? '';
      });
      // Authentication successful, navigate to next screen
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 2.0,
          showCloseIcon: true,
          backgroundColor: Colors.red[100],
          content: Text(
            'Authentication failed!',
            style: TextStyle(
              color: Colors.red[900],
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
