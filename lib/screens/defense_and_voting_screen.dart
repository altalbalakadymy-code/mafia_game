import 'dart:async';
import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../models/voting_model.dart';

class DefenseAndVotingScreen extends StatefulWidget {
  final Player accusedPlayer;
  final List<Player> allPlayers;
  final String currentVoterId; // معرف اللاعب الحالي الذي يستخدم الجهاز

  const DefenseAndVotingScreen({
    super.key,
    required this.accusedPlayer,
    required this.allPlayers,
    required this.currentVoterId,
  });

  @override
  State<DefenseAndVotingScreen> createState() => _DefenseAndVotingScreenState();
}

class _DefenseAndVotingScreenState extends State<DefenseAndVotingScreen> {
  final VoteManager _voteManager = VoteManager();
  int _timerSeconds = 30; // وقت الدفاع أو التصويت
  Timer? _timer;
  bool _hasVoted = false;

  @override
  void initState() {
    super.initState();
    _voteManager.startDefense(widget.accusedPlayer.id);
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          if (_voteManager.status == DefenseStatus.defending) {
            // انتهاء وقت الدفاع، الانتقال لتصويت العفو
            _voteManager.openAcquittalVoting();
            _timerSeconds = 15; 
          } else {
            // انتهاء وقت التصويت بالكامل
            _timer.cancel();
            _finishVotingProcess();
          }
        }
      });
    });
  }

  void _finishVotingProcess() {
    bool saved = _voteManager.yesVotes > _voteManager.noVotes;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text('نتيجة محكمة النهار ⚖️', style: TextStyle(color: Colors.white)),
        content: Text(
          saved 
              ? 'تم العفو عن اللاعب ${widget.accusedPlayer.name} بأغلبية الأصوات! (نجا بأعجوبة)'
              : 'تم تثبيت الإدانة وإعدام اللاعب ${widget.accusedPlayer.name}!',
          style: const TextStyle(color: Colors.amberAccent, fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
            onPressed: () {
              Navigator.pop(context); // إغلاق الحوار
              Navigator.pop(context); // العودة للشاشة الرئيسية للعبة
            },
            child: const Text('متابعة اللعبة'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDefendingPhase = _voteManager.status == DefenseStatus.defending;

    return Scaffold(
      backgroundColor: const Color(0xFF14141A),
      appBar: AppBar(
        title: const Text('محكمة النهار والدفاع الأخير'),
        backgroundColor: Colors.red.shade900,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDefendingPhase ? Icons.mic : Icons.how_to_vote,
              size: 70,
              color: isDefendingPhase ? Colors.orangeAccent : Colors.redAccent,
            ),
            const SizedBox(height: 15),
            Text(
              isDefendingPhase ? 'مرحلة الدفاع عن النفس' : 'مرحلة التصويت الحاسم (هل ننجيه؟)',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'اللاعب المعرض للإقصاء: ${widget.accusedPlayer.name}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // مؤقت العد التنازلي الدائري
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    value: _timerSeconds / (isDefendingPhase ? 30 : 15),
                    strokeWidth: 6,
                    color: Colors.redAccent,
                    backgroundColor: Colors.grey.shade800,
                  ),
                ),
                Text(
                  '$_timerSeconds ث',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // محتوى الشاشة بناءً على المرحلة الحالية
            if (isDefendingPhase)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'الدور الآن على ${widget.accusedPlayer.name} ليدافع عن نفسه شفهياً ويثبت براءته أمام الجميع قبل بدء التصويت!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              )
            else 
              _hasVoted
                  ? const Text('تم تسجيل صوتك بنجاح.. بانتظار بقية اللاعبين.', style: TextStyle(color: Colors.greenAccent, fontSize: 16))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800, padding: const EdgeInsets.all(15)),
                          onPressed: () {
                            setState(() {
                              _voteManager.castVote(widget.currentVoterId, true);
                              _hasVoted = true;
                            });
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('عفو / نجاة', style: TextStyle(fontSize: 16)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade800, padding: const EdgeInsets.all(15)),
                          onPressed: () {
                            setState(() {
                              _voteManager.castVote(widget.currentVoterId, false);
                              _hasVoted = true;
                            });
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('إدانة / إعدام', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
