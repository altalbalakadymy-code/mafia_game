import 'package:flutter/material.dart';

class GhostChatScreen extends StatelessWidget {
  const GhostChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('غرفة دردشة الأشباح (الموتى) 👻'),
        backgroundColor: Colors.deepPurple.shade900,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'لقد غادرت عالم الأحياء! يمكنك التحدث هنا بحرية مع بقية الموتى دون إزعاج الأحياء.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                Text('صلاح: هههههه حتى أنت تم إقصاؤك؟', style: TextStyle(color: Colors.purpleAccent)),
                SizedBox(height: 8),
                Text('محمد: نعم، لقد خدعونا في التصويت!', style: TextStyle(color: Colors.white75)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'تحدث مع الأموات...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.purpleAccent),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
