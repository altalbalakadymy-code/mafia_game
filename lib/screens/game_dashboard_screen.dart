import 'package:flutter/material.dart';
import '../models/player_model.dart';

class GameDashboardScreen extends StatefulWidget {
  final List<Player> players;

  const GameDashboardScreen({super.key, required this.players});

  @override
  State<GameDashboardScreen> createState() => _GameDashboardScreenState();
}

class _GameDashboardScreenState extends State<GameDashboardScreen> {
  String latestNotification = "بدء الجلسة بنجاح.. تنتظر مرحلة الليل.";

  void _triggerNotification(String message) {
    setState(() {
      latestNotification = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade800,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم مدير اللعبة ⚙️'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // شريط الإشعارات الحية
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade900.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active, color: Colors.amber),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'الإشعار الحالي: $latestNotification',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'إدارة حالة اللاعبين في الوقت الفعلي:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.players.length,
                itemBuilder: (context, index) {
                  var p = widget.players[index];
                  return Card(
                    color: Colors.grey.shade900,
                    child: ListTile(
                      title: Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text('الدور: ${p.role.name} | الحالة: ${p.status.name}', style: const TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.local_hospital, color: Colors.greenAccent),
                            tooltip: 'إرسال إشعار شفاء',
                            onPressed: () => _triggerNotification('🏥 تم شفاء اللاعب ${p.name} بواسطة الطبيب!'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic_off, color: Colors.orangeAccent),
                            tooltip: 'إرسال إشعار تسكيت',
                            onPressed: () => _triggerNotification('🔇 تم تسكيت اللاعب ${p.name} في هذه الجولة!'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.dangerous, color: Colors.redAccent),
                            tooltip: 'إرسال إشعار اغتيال',
                            onPressed: () {
                              setState(() {
                                p.status = PlayerStatus.dead;
                              });
                              _triggerNotification('💀 تم اغتيال اللاعب ${p.name} ليلاً!');
                            },
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
