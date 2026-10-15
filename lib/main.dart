import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MafiaLocalApp());
}

class MafiaLocalApp extends StatelessWidget {
  const MafiaLocalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لعبة المافيا المحلية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Colors.red.shade800,
          secondary: Colors.amber,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
