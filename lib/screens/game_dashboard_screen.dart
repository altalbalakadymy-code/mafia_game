import 'package:flutter/material.dart';
import '../models/player_model.dart';

class GameDashboardScreen extends StatefulWidget {
  final List<Player> players;

  const GameDashboardScreen({super.key, required this.players});

  @override
  State<GameDashboardScreen> createState() => _GameDashboardScreenState();
}

class _GameDashboardScreenState extends State<GameDashboardScreen> {
  String _currentEventLog = "بدء الجلسة.. مرحلة الليل الأولى.";

  void _broadcastEvent(String message) {
    setState(() {
      _currentEventLog = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        backgroundColor: Colors.red.shade900,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم المدير والحدث الحي 🎮'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // شريط الإشعارات الحية في اللعبة
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade900.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.campaign, color: Colors.amber, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'الحدث الفوري: $_currentEventLog',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'إدارة قرارات وأحداث اللاعبين (تحديث فوري للأجهزة):',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
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
                      subtitle: Text('الحالة: ${p.status == PlayerStatus.alive ? "حي 🟢" : "ميت 💀"}', style: const TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // زر الشفاء
                          IconButton(
                            icon: const Icon(Icons.medical_services, color: Colors.greenAccent),
                            tooltip: 'إشعار شفاء من الطبيب',
                            onPressed: () => _broadcastEvent('🏥 قام الطبيب بإنقاذ الشاب ${p.name} ليلاً!'),
                          ),
                          // زر التسكيت
                          IconButton(
                            icon: const Icon(Icons.mic_off, color: Colors.orangeAccent),
                            tooltip: 'إشعار تسكيت',
                            onPressed: () => _broadcastEvent('🔇 تم إسكات اللاعب ${p.name} ولا يمكنه التكلم غداً!'),
                          ),
                          // زر الاغتيال
                          IconButton(
                            icon: const Icon(Icons.flash_on, color: Colors.redAccent),
                            tooltip: 'تأكيد اغتيال اللاعب',
                            onPressed: () {
                              setState(() {
                                p.status = PlayerStatus.dead;
                              });
                              _broadcastEvent('💀 نأسف، لقد تم اغتيال اللاعب ${p.name} وأصبح في عداد الأموات!');
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
