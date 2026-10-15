import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'player_profile_screen.dart';
import '../models/player_model.dart';

class JoinGameScreen extends StatefulWidget {
  final List<Player> gamePlayers; // قائمة اللاعبين الحقيقيين المسجلين عند المدير

  const JoinGameScreen({super.key, required this.gamePlayers});

  @override
  State<JoinGameScreen> createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isScanning = false;

  void _verifyAndJoin(String pinOrCode) {
    // البحث عن اللاعب المطابق للرمز أو الـ QR
    Player? foundPlayer = widget.gamePlayers.firstWhere(
      (p) => p.pinCode == pinOrCode || pinOrCode.contains(p.pinCode),
      orElse: () => Player(id: '', name: '', pinCode: ''),
    );

    if (foundPlayer.id.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PlayerProfileScreen(
            player: foundPlayer,
            allPlayers: widget.gamePlayers,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرمز أو الكود غير صحيح! تأكد من المدير.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isScanning) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('امسك كود الـ QR الخاص بك'),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => setState(() => _isScanning = false),
          ),
        ),
        body: MobileScanner(
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                setState(() => _isScanning = false);
                _verifyAndJoin(barcode.rawValue!);
                break;
              }
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('انضمام لاعب للعبة'), backgroundColor: Colors.red.shade900),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 90, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              'اختر طريقة الانضمام:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade800,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () => setState(() => _isScanning = true),
              icon: const Icon(Icons.camera_alt),
              label: const Text('تصوير رمز الـ QR بالكاميرا', style: TextStyle(fontSize: 16)),
            ),
            const Divider(height: 40, color: Colors.grey),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'أو أدخل رمز الدخول السري (PIN)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () => _verifyAndJoin(_pinController.text),
              child: const Text('دخول بالرمز اليدوي', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
