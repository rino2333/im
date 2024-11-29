import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 根部件
      title: 'login demo',
      home: FutureBuilder(
        future: getToken(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading token'));
          } else {
            final token = snapshot.data;
            return token != null ? HomePage() : LoginPage();
          }
        }
      ),
    );
  }

  Future<String?> getToken() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs?.getString('token');
  }
}


