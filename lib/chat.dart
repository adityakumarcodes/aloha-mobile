import 'package:aloha_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var friendProvider = context.watch<FriendProvider>();
    int selectedIndex = friendProvider.friendSelectedToChat;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
        elevation: 2,
        // shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: chatUsers.length,
            // padding: const EdgeInsets.only(top: 20, bottom: 80),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: (() {
                  setState(() => selectedIndex = index);
                  friendProvider.setFriendSelectedToChat(index);
                  context.push('/chat/details');
                }),
                shape: Border(top: BorderSide(color: Colors.black, width: 2)),
                tileColor:
                    selectedIndex == index
                        ? Colors.grey[200]
                        : Colors.transparent,
                leading: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(chatUsers[index].imageURL),
                      maxRadius: 30,
                    ),
                    if ((index % 3 == 0) == false)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  chatUsers[index].name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(chatUsers[index].messageText),
                trailing: Text(chatUsers[index].time),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        tooltip: 'New chat',
        child: Icon(LucideIcons.messageSquarePlus),
      ),
    );
  }
}
