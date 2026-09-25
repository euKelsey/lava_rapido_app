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

      themeMode: ThemeMode.system,

      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      home: const LoginScreen(),
    );
  }
}
