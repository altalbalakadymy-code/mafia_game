import 'package:flutter/material.dart';
import 'player_notes_screen.dart';

class JoinGameScreen extends StatefulWidget {
  const JoinGameScreen({super.key});

  @override
  State<JoinGameScreen> createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('انضمام لاعب للغرفة')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 80, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text('قم بمسح رمز الـ QR الخاص بشخصيتك أو أدخل رمز الدخول (PIN):', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'رمز الدخول (PIN Code)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800, minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                if (_pinController.text.isEmpty) return;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PlayerNotesScreen()));
              },
              child: const Text('دخول اللعبة', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
