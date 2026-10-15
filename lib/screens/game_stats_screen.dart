import 'package:flutter/material.dart';
import '../models/player_model.dart';

class GameStatsScreen extends StatelessWidget {
  final String winMessage;
  final List<Player> allPlayers;
  final int totalRounds;
  final VoidCallback onRestart;

  const GameStatsScreen({
    super.key,
    required this.winMessage,
    required this.allPlayers,
    required this.totalRounds,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    // إيجاد اللاعبين الذين توفوا أو بقوا أحياء
    var deadPlayers = allPlayers.where((p) => p.status == PlayerStatus.dead).toList();
    var alivePlayers = allPlayers.where((p) => p.status == PlayerStatus.alive).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF101016),
      appBar: AppBar(
        title: const Text('إحصائيات وملخص الجولة 📊'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: constشف EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة النتيجة الكبرى
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade900.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.redAccent, width: 1.5),
              ),
              child: Column(
                children: [
                  const Icon(Icons.military_tech, size: 50, color: Colors.amber),
                  const SizedBox(height: 8),
                  Text(
                    winMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: النافع ? 20 : 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'عدد الجولات الكلي: $totalRounds جولات',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'أرواح المدينة (الناجون والأموات):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            
            // قائمة اللاعبين وحالتهم النهائية
            Expanded(
              child: ListView.builder(
                itemCount: allPlayers.length,
                itemBuilder: (context, index) {
                  var p = allPlayers[index];
                  bool isAlive = p.status == PlayerStatus.alive;
                  return Card(
                    color: Colors.grey.shade900,
                    child: ListTile(
                      leading: Icon(
                        isAlive ? Icons.mood : Icons.sentiment_very_dissatisfied,
                        color: isAlive ? Colors.greenAccent : Colors.redAccent,
                      ),
                      title: Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'الدور: ${p.role.name}',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      trailing: Text(
                        isAlive ? 'حي 🟢' : 'ميت 🔴',
                        style: TextStyle(
                          color: isAlive ? Colors.greenAccent : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text('بدء لعبة جديدة كلياً', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
