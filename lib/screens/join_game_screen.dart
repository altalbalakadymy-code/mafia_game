import 'package:flutter/material.dart';
import 'player_notes_screen.dart';

class JoinGameScreen extends StatefulWidget {
  const JoinGameScreen({super.key});

  @override
  State<JoinGameScreen> createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  final _nameCtrl = TextEditingController();
  final _ipCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الانضمام للعبة')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'اسمك المستعار', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            TextField(controller: _ipCtrl, decoration: const InputDecoration(labelText: 'عنوان IP المدير', border: OutlineInputBorder())),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800, minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlayerNotesScreen()),
                );
              },
              child: const Text('دخول الغرفة ومفكرتي', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
