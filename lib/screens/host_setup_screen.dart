import 'package:flutter/material.dart';
import 'qr_host_screen.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({super.key});

  @override
  State<HostSetupScreen> createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  int _playerCount = 8;
  bool _enableSilenceMafia = true;
  bool _enableDoctor = true;
  bool _enableSniper = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعداد غرفة المافيا (المدير)')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text('اختر عدد اللاعبين في الجلسة المحلية:', style: TextStyle(fontSize: 16)),
            Slider(
              value: _playerCount.toDouble(),
              min: 5,
              max: 20,
              divisions: 15,
              label: '$_playerCount لاعباً',
              activeColor: Colors.redAccent,
              onChanged: (val) => setState(() => _playerCount = val.toInt()),
            ),
            Text('العدد المحدد: $_playerCount لاعباً', textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Colors.amber)),
            const Divider(height: 40),
            SwitchListTile(
              title: const Text('مافيا التسكيت'),
              value: _enableSilenceMafia,
              onChanged: (val) => setState(() => _enableSilenceMafia = val),
            ),
            SwitchListTile(
              title: const Text('الإسعاف (الطبيب)'),
              value: _enableDoctor,
              onChanged: (val) => setState(() => _enableDoctor = val),
            ),
            SwitchListTile(
              title: const Text('قناص الصالحين'),
              value: _enableSniper,
              onChanged: (val) => setState(() => _enableSniper = val),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800, padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrHostScreen(playerCount: _playerCount)),
                );
              },
              icon: const Icon(Icons.wifi_tethering),
              label: const Text('فتح الغرفة وعرض QR', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
