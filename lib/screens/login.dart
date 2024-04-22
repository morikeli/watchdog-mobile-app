import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watchdog/components/login_form.dart';
import 'package:watchdog/constants/api.dart';
import 'package:watchdog/constants/colors.dart';
import 'package:watchdog/screens/homepage.dart';
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
  String authURL = '$api/auth/login';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    try {
      http.Response response = await http.post(
        Uri.parse(authURL),
        headers: <String, String>{
        'Authorization':'Bearer ${base64Encode(utf8.encode('$username:$password'))}',
        'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      
      setState(() {
        if (response.statusCode == 200) {
          // Authentication successful, navigate to next screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else {
          isLoading = false;
          Fluttertoast.showToast(
            msg: 'Invalid credentials! Please try again.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red.shade600,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }); 
    
    } catch (e) {
      setState(() => isLoading= false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 2.0,
          showCloseIcon: true,
          closeIconColor: Colors.black,
          backgroundColor: Colors.red[100],
          content: Text(
            'ERROR! Check your internet connection.',
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
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: isLoading 
        ? const Center(
          child: CircularProgressIndicator.adaptive()
        )
        : Card(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            LoginForm(
              formKey: _formKey,
              username: _usernameController, 
              password: _passwordController,
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Stack(
                children: [
                    Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimaryColor
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                      child: const Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                  ),  
                ]
              ),
            ),
          ],
                ),
        )
    );
  }
}
