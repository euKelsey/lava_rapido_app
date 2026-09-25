import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const LavaRapidoApp());
}

class LavaRapidoApp extends StatelessWidget {
  const LavaRapidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Splash',
      home: const LoginScreen(),
    );
  }
}