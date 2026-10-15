import 'package:flutter/material.dart';
import 'host_setup_screen.dart';
import 'join_game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لعبة المافيا (بدون إنترنت)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.nightlife, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              'أهلاً بك في مدينة الظلام',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HostSetupScreen()),
                );
              },
              icon: const Icon(Icons.add_moderator),
              label: const Text('إنشاء لعبة جديدة (مدير اللعبة)', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.redAccent, width: 2),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JoinGameScreen()),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('انضمام إلى لعبة قائمة', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
