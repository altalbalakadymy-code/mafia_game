import 'package:flutter/material.dart';
import '../models/player_model.dart';

class HostNightDashboard extends StatefulWidget {
  final List<Player> players;
  final Function(String, String, String) onNightFinished;

  const HostNightDashboard({super.key, required this.players, required this.onNightFinished});

  @override
  State<HostNightDashboard> createState() => _HostNightDashboardState();
}

class _HostNightDashboardState extends State<HostNightDashboard> {
  String? mafiaVictim, savedVictim, mutedPlayer;
  int step = 1;

  @override
  Widget build(BuildContext context) {
    var alive = widget.players.where((p) => p.status == PlayerStatus.alive).toList();

    return Scaffold(
      appBar: AppBar(title: Text(step == 1 ? 'الليل: اختيار المافيا' : step == 2 ? 'الليل: اختيار الطبيب' : 'الليل: التسكيت'), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(step == 1 ? 'اختر ضحية المافيا:' : step == 2 ? 'اختر من سيحميه الطبيب:' : 'اختر من سيتم تسكينه:', style: const TextStyle(color: Colors.amber, fontSize: 16)),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: alive.length,
                itemBuilder: (context, index) {
                  var p = alive[index];
                  bool selected = (step == 1 && mafiaVictim == p.id) || (step == 2 && savedVictim == p.id) || (step == 3 && mutedPlayer == p.id);
                  return Card(
                    color: selected ? Colors.red.shade900 : Colors.grey.shade900,
                    child: ListTile(
                      title: Text(p.name),
                      onTap: () => setState(() {
                        if (step == 1) mafiaVictim = p.id;
                        else if (step == 2) savedVictim = p.id;
                        else mutedPlayer = p.id;
                      }),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                if (step < 3) setState(() => step++);
                else widget.onNightFinished(mafiaVictim ?? '', savedVictim ?? '', mutedPlayer ?? '');
              },
              child: Text(step < 3 ? 'التالي' : 'شروق الشمس (إعلان النتائج)', style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
