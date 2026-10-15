import 'package:flutter/material.dart';
import '../models/player_model.dart';

class HostNightDashboard extends StatefulWidget {
  final List<Player> players;
  final Function(String mafiaTarget, String doctorTarget, String muteTarget) onNightFinished;

  const HostNightDashboard({
    super.key,
    required this.players,
    required this.onNightFinished,
  });

  @override
  State<HostNightDashboard> createState() => _HostNightDashboardState();
}

class _HostNightDashboardState extends State<HostNightDashboard> {
  String? mafiaTarget;
  String? doctorTarget;
  String? muteTarget;
  int nightStep = 1;

  @override
  Widget build(BuildContext context) {
    // جلب اللاعبين الأحياء من القائمة الحقيقية التي أنشأها المدير فقط
    var alivePlayers = widget.players.where((p) => p.status == PlayerStatus.alive).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          nightStep == 1
              ? 'الليل: شيخ المافيا يختار'
              : nightStep == 2
                  ? 'الليل: الطبيب ينقذ'
                  : 'الليل: مافيا التسكيت',
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              nightStep == 1
                  ? 'اختر الشخص المستهدف للاغتيال ليلاً:'
                  : nightStep == 2
                      ? 'اختر الشخص لإنقاذ حياته:'
                      : 'اختر الشخص لمنعه من الكلام غداً:',
              style: const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: alivePlayers.length,
                itemBuilder: (context, index) {
                  var p = alivePlayers[index];
                  bool isSelected = (nightStep == 1 && mafiaTarget == p.id) ||
                      (nightStep == 2 && doctorTarget == p.id) ||
                      (nightStep == 3 && muteTarget == p.id);
                  return Card(
                    color: isSelected ? Colors.red.shade900 : Colors.grey.shade900,
                    child: ListTile(
                      title: Text(p.name, style: const TextStyle(color: Colors.white)),
                      onTap: () => setState(() {
                        if (nightStep == 1) {
                          mafiaTarget = p.id;
                        } else if (nightStep == 2) {
                          doctorTarget = p.id;
                        } else {
                          muteTarget = p.id;
                        }
                      }),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (nightStep < 3) {
                  setState(() => nightStep++);
                } else {
                  widget.onNightFinished(
                    mafiaTarget ?? '',
                    doctorTarget ?? '',
                    muteTarget ?? '',
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(
                nightStep < 3 ? 'الخطوة التالية' : 'شروق الشمس وإعلان النتائج',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
