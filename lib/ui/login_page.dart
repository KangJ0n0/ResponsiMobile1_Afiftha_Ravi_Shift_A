import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/helpers/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _apiService = ApiService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  void _login() async {
    try {
      final result = await _apiService.login(
        _emailController.text,
        _passwordController.text,
      );

      if (result['status']) {
        // Navigate to Ulasan Page after successful login
        Navigator.pushReplacementNamed(context, '/ulasan');
      } else {
        setState(() {
          _message = 'Login failed';
        });
      }
    } catch (error) {
      setState(() {
        _message = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
