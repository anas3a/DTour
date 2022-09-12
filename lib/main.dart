import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DTour',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/signUp_page': (context) => const SignupPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
