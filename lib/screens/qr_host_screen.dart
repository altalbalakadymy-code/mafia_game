import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'host_night_dashboard.dart';
import '../models/player_model.dart';

class QrHostScreen extends StatefulWidget {
  final int playerCount;
  const QrHostScreen({super.key, required this.playerCount});

  @override
  State<QrHostScreen> createState() => _QrHostScreenState();
}

class _QrHostScreenState extends State<QrHostScreen> {
  String _hostIp = "192.168.43.1";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getIp();
  }

  Future<void> _getIp() async {
    try {
      String? ip = await NetworkInfo().getWifiIP();
      if (ip != null) setState(() => _hostIp = ip);
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('غرفة الانتظار (المدير)')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('اجعل اللاعبين يتصلون بنقطة الاتصال (Hotspot) ويمسحون الكود:', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            _isLoading ? const CircularProgressIndicator() : Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: QrImageView(data: "$_hostIp:8080", size: 180),
            ),
            const SizedBox(height: 20),
            Text('IP: $_hostIp:8080', style: const TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold)),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                // مثال تجريبي للانتقال للوحة تحكم المدير الليلية
                List<Player> samplePlayers = [
                  Player(id: '1', name: 'أحمد', role: PlayerRole.mafiaBoss),
                  Player(id: '2', name: 'محمد', role: PlayerRole.doctor),
                  Player(id: '3', name: 'صلاح', role: PlayerRole.citizen),
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HostNightDashboard(
                      players: samplePlayers,
                      onNightFinished: (m, s, mu) {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              child: const Text('بدء الليل (لوحة المدير)', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
