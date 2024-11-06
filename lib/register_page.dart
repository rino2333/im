import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  String _errorMessage = '';
  String _successMessage = '';

  Future _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final nickname = _nicknameController.text;

    if (username.isEmpty || password.isEmpty || nickname.isEmpty) {
       setState(() {
        _errorMessage = 'Username or password or nickname cannot be empty!';
        _successMessage = '';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://47.245.82.251:31104/api/community/auth/register'),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'communityInfo': {
            'nickname': nickname
          }
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 0) {
          setState(() {
            _successMessage = 'Registration successful!';
            _errorMessage = '';
            Navigator.pop(context);
          });
        } else {
          setState(() {
            _errorMessage = 'Registration error! Status code: ${response.statusCode}, Status message: ${responseData['message']}';
            _successMessage = '';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Registration error! Status code: ${response.statusCode}, Status message: ${response.body}';
          _successMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Registration error! Please check your connection.';
        _successMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
            ),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(labelText: 'nickname'),
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: _register, child: const Text('Register')),
            if (_successMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _successMessage,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),  
      ),
    );
  }
}
