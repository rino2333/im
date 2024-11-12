import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register_page.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String _successMessage = '';

  Future setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'username or password can not be empty!';
        _successMessage = '';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://47.245.82.251:31104/api/auth/login'),
         headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userName': username,
          'password': password,
          'expireDays': 100,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 0) {
          print('login succes!${responseData}');
          setState(() {
            _successMessage = 'Login successful!';
            _errorMessage = '';
            setToken(responseData['data']['token']);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          });
        } else {
          print('login succes!${responseData}');
          setState(() {
            _errorMessage = 'Login error!${responseData['message']}';
            _successMessage = '';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'login error! statusCode: ${response.statusCode}';
          _successMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'login error! Please check your connection.';
        _successMessage = '';
        print('$e');
      });
    }
  }
  
  void _navigateToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              decoration: const InputDecoration(labelText: 'password'),
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _login, child: const Text('login')),
                const SizedBox(width: 10,),
                ElevatedButton(onPressed: _navigateToRegister, child: const Text('Register')),
              ],
            ),
            
            if (_errorMessage.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (_successMessage.isNotEmpty) 
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _successMessage,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
