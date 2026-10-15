import 'package:flutter/material.dart';
import '../models/player_model.dart';

class SecretRoleScreen extends StatelessWidget {
  final PlayerRole role;
  final VoidCallback onAcknowledged;

  const SecretRoleScreen({super.key, required this.role, required this.onAcknowledged});

  String getRoleName() {
    switch (role) {
      case PlayerRole.mafiaBoss:
        return 'شيخ المافيا (تغتال ليلاً)';
      case PlayerRole.mafiaMute:
        return 'مافيا التسكيت (تمنع شخصاً من الكلام)';
      case PlayerRole.doctor:
        return 'الطبيب (الإسعاف - تحمي الضحية)';
      case PlayerRole.sniper:
        return 'القناص (تملك رصاصة قاتلة واحدة)';
      case PlayerRole.detective:
        return 'العمدة (صوتك يحسب بـ 3 أصوات عند الكشف)';
      case PlayerRole.goodKid:
        return 'الولد الصالح (إذا مت تسحب معك شخصاً)';
      default:
        return 'مواطن صالح (شارك بالنقاش والتصويت)';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEvil = role == PlayerRole.mafiaBoss || role == PlayerRole.mafiaMute;

    return Scaffold(
      backgroundColor: isEvil ? const Color(0xFF2A0808) : const Color(0xFF082A08),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              isEvil ? Icons.security : Icons.shield,
              size: 90,
              color: isEvil ? Colors.redAccent : Colors.greenAccent,
            ),
            const SizedBox(height: 30),
            const Text(
              'دورك السري في اللعبة هو:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 15),
            Text(
              getRoleName(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isEvil ? Colors.red.shade200 : Colors.green.shade200,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'احفظ دورك سراً ولا تطلع أي شخص عليه!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.amber),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isEvil ? Colors.red.shade900 : Colors.green.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: onAcknowledged,
              child: const Text('فهمت، إخفاء الدور', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
