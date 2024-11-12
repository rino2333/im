import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
          print('1$context');
          print('2$snapshot');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading token'));
          } else {
            print('3${snapshot.data}');
            // If the token exists, navigate to HomePage; otherwise, show LoginPage
            final token = snapshot.data;
            return token != null ? HomePage() : LoginPage();
          }
        }
      ),
    );
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}


