import 'package:flutter/material.dart';
import '../models/player_model.dart';

class PlayerProfileScreen extends StatelessWidget {
  final Player player;
  final int totalGamesPlayed;
  final int winsCount;

  const PlayerProfileScreen({
    super.key,
    required this.player,
    this.totalGamesPlayed = 3,
    this.winsCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121218),
      appBar: AppBar(
        title: Text('صفحة اللاعب: ${player.name}'),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 15),
            Text(
              player.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              'رمز الدخول: ${player.pinCode}',
              style: const TextStyle(color: Colors.amber, fontSize: 14),
            ),
            const Divider(height: 40, color: Colors.grey),
            
            // بطاقة الدور الحالي
            Card(
              color: Colors.grey.shade900,
              child: ListTile(
                leading: const Icon(Icons.shield, color: Colors.redAccent),
                title: const Text('دورك السري الحالي', style: TextStyle(color: Colors.grey)),
                subtitle: Text(
                  player.role.name.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // بطاقة الإحصائيات
            Card(
              color: Colors.grey.shade900,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('الجولات الملعوبة', style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        Text('$totalGamesPlayed', style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('الانتصارات', style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        Text('$winsCount', style: const TextStyle(fontSize: 20, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              player.status == PlayerStatus.alive ? 'الحالة: حي 🟢' : 'الحالة: ميت 🔴',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: player.status == PlayerStatus.alive ? Colors.greenAccent : Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
