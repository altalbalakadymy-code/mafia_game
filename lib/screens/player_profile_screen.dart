import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/player_model.dart';

class PlayerProfileScreen extends StatefulWidget {
  final Player player;
  final List<Player> allPlayers;

  const PlayerProfileScreen({super.key, required this.player, required this.allPlayers});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  final Map<String, TextEditingController> _notesControllers = {};

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    for (var p in widget.allPlayers) {
      String savedNote = prefs.getString('note_${widget.player.id}_${p.id}') ?? '';
      _notesControllers[p.id] = TextEditingController(text: savedNote);
    }
    setState(() {});
  }

  Future<void> _saveNote(String targetPlayerId, String noteText) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('note_${widget.player.id}_$targetPlayerId', noteText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101014),
      appBar: AppBar(
        title: Text('لوحة اللاعب: ${widget.player.name}'),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة بيانات اللاعب الشخصية
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.redAccent),
              ),
              child: Column(
                children: [
                  Text('اسمك: ${widget.player.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text('دورك السري: ${widget.player.role.name.toUpperCase()}', style: const TextStyle(color: Colors.amber, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text('الحالة: ${widget.player.status == PlayerStatus.alive ? "حي 🟢" : "ميت 🔴"}', style: TextStyle(color: widget.player.status == PlayerStatus.alive ? Colors.greenAccent : Colors.redAccent)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'قائمة اللاعبين المشتركين والملاحظات الخاصة بك:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            
            // قائمة اللاعبين مع خانة ملاحظة مخصصة أمام كل لاعب
            Expanded(
              child: ListView.builder(
                itemCount: widget.allPlayers.length,
                itemBuilder: (context, index) {
                  var otherPlayer = widget.allPlayers[index];
                  if (!_notesControllers.containsKey(otherPlayer.id)) {
                    _notesControllers[otherPlayer.id] = TextEditingController();
                  }

                  return Card(
                    color: Colors.grey.shade900,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                otherPlayer.name,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                // الدور مخفي تماماً إلا إذا مات أو كشفته اللعبة
                                otherPlayer.status == PlayerStatus.dead 
                                    ? 'الدور: ${otherPlayer.role.name} (ميت 💀)' 
                                    : 'الدور: [ مخفي 🔒 ]',
                                style: TextStyle(
                                  color: otherPlayer.status == PlayerStatus.dead ? Colors.redAccent : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _notesControllers[otherPlayer.id],
                            onChanged: (val) => _saveNote(otherPlayer.id, val),
                            decoration: InputDecoration(
                              hintText: 'اكتب ملاحظتك السرية عن ${otherPlayer.name}...',
                              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              filled: true,
                              fillColor: Colors.black45,
                            ),
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
