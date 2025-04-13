import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New chat',
        child: Icon(LucideIcons.messageSquarePlus),
      ),
    );
  }
}
