import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/player_model.dart';
import 'host_night_dashboard.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({super.key});

  @override
  State<HostSetupScreen> createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  final List<Player> _players = [];
  final TextEditingController _nameController = TextEditingController();
  bool _isHotspotActive = false;

  void _addPlayer() {
    if (_nameController.text.isEmpty) return;
    if (_players.length >= 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الحد الأقصى 20 لاعباً')),
      );
      return;
    }

    String pin = (1000 + _players.length * 123).toString().substring(0, 4);
    setState(() {
      _players.add(Player(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        pinCode: pin,
      ));
      _nameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الغرفة (المدير)'),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text(
                'تأكيد تفعيل نقطة الاتصال (Hotspot)',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              subtitle: const Text('يجب فتح الـ Hotspot لتوصيل اللاعبين محلياً'),
              value: _isHotspotActive,
              activeColor: Colors.green,
              onChanged: (val) => setState(() => _isHotspotActive = val),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'اسم اللاعب الجديد',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isHotspotActive ? _addPlayer : null,
                  child: const Text('إضافة'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _players.length,
                itemBuilder: (context, index) {
                  var p = _players[index];
                  return Card(
                    color: Colors.grey.shade900,
                    child: ListTile(
                      title: Text(
                        p.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'رمز الدخول (PIN): ${p.pinCode}',
                        style: const TextStyle(color: Colors.amber),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.qr_code, color: Colors.white),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('رمز اللاعب: ${p.name}'),
                                  content: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: QrImageView(
                                      data: "MAFIA_PLAYER_${p.id}_PIN_${p.pinCode}",
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => setState(() => _players.removeAt(index)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isHotspotActive && _players.length >= 5
                    ? Colors.green.shade700
                    : Colors.grey,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: _isHotspotActive && _players.length >= 5
                  ? () {
                      // تمرير قائمة اللاعبين الحقيقيين حصرياً بدون أي قيم افتراضية
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HostNightDashboard(
                            players: _players,
                            onNightFinished: (mafiaTarget, doctorTarget, muteTarget) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('انتهى الليل وتمت معالجة قرارات اللاعبين الحقيقيين!'),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text(
                'بدء الجلسة وتوزيع الأدوار (الحد الأدنى 5 لاعبين)',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
