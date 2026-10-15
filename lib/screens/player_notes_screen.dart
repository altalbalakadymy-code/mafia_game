import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerNotesScreen extends StatefulWidget {
  const PlayerNotesScreen({super.key});

  @override
  State<PlayerNotesScreen> createState() => _PlayerNotesScreenState();
}

class _PlayerNotesScreenState extends State<PlayerNotesScreen> {
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => _ctrl.text = prefs.getString('notes') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مفكرتي السرية 📝')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('اكتب شكوكك وملاحظاتك الخاصة (لا أحد يراها غيرك):', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _ctrl,
                maxLines: null,
                expands: true,
                onChanged: (val) => SharedPreferences.getInstance().then((p) => p.setString('notes', val)),
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'اكتب هنا...'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
