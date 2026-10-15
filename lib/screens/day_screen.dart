import 'package:flutter/material.dart';

class DayScreen extends StatefulWidget {
  final bool isMuted;
  final VoidCallback onProceedToVoting;

  const DayScreen({
    super.key,
    required this.isMuted,
    required this.onProceedToVoting,
  });

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"sender": "المدير", "text": "شرفت شمس النهار! ناقشوا من هو المشتبه به."},
  ];

  void _sendMessage() {
    if (_msgController.text.isEmpty || widget.isMuted) return;
    setState(() {
      _messages.add({"sender": "أنت", "text": _msgController.text});
      _msgController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرحلة النهار - النقاش الجماعي'),
        backgroundColor: Colors.brown.shade800,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.how_to_vote, color: Colors.amber),
            onPressed: widget.onProceedToVoting,
            tooltip: 'الانتقال للتصويت',
          ),
        ],
      ),
      body: Column(
        children: [
          if (widget.isMuted)
            Container(
              color: Colors.red.shade900,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: const Text(
                '⚠️ تم منعك من الكلام في هذه الجولة بواسطة مافيا التسكيت!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var msg = _messages[index];
                bool isMe = msg["sender"] == "أنت";
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.brown.shade700 : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${msg["sender"]}: ${msg["text"]}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    enabled: !widget.isMuted,
                    decoration: InputDecoration(
                      hintText: widget.isMuted ? 'أنت ممنوع من الكلام...' : 'اكتب رسالتك للنقاش...',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.amber),
                  onPressed: widget.isMuted ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
