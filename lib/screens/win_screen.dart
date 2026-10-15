import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  final String winMessage;
  final VoidCallback onRestartGame;

  const WinScreen({super.key, required this.winMessage, required this.onRestartGame});

  @override
  Widget build(BuildContext context) {
    bool isMafiaWin = winMessage.contains('المافيا');

    return Scaffold(
      backgroundColor: isMafiaWin ? const Color(0xFF1A0000) : const Color(0xFF001A00),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              isMafiaWin ? Icons.local_fire_department : Icons.verified,
              size: 100,
              color: isMafiaWin ? Colors.redAccent : Colors.greenAccent,
            ),
            const SizedBox(height: 30),
            Text(
              winMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isMafiaWin ? Colors.red.shade200 : Colors.green.shade200,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isMafiaWin ? Colors.red.shade900 : Colors.green.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: onRestartGame,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة بدء جولة جديدة (Restart)', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
