import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/spot_details_screen.dart';
import 'Screens/tour_input_screen.dart';
import 'Screens/cost_details_screen.dart';
import 'Screens/tour_purchase_history.dart';

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
        '/home_page': (context) => const HomePage(),
        '/spot_details_page': (context) => const SpotDetailsPage(),
        '/tour_input_page': (context) => const TourInputPage(),
        '/cost_details_page': (context) => const CostDetailsPage(),
        '/purchase_history_page': (context) => const TourPurchaseHistory(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
