import 'package:aloha_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  Widget build(BuildContext context) {
    var friendProvider = context.watch<FriendProvider>();
    int selectedIndex = friendProvider.friendSelectedToChat;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // // Header UI
          // const Padding(
          //   padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          //   child: Text(
          //     "Messages",
          //     style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(6,16,6,0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                // hintStyle: TextStyle(color: Colors.grey.shade300),
                prefixIcon: Icon(
                  Icons.search,
                  // color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                // fillColor: Colors.grey.shade300,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black,width: 2),
                ),
              ),
            ),
          ),
          //conversation list view
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: chatUsers.length,
              padding: const EdgeInsets.only(top: 20, bottom: 80),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (() {
                    setState(() => selectedIndex = index);
                    friendProvider.setFriendSelectedToChat(index);
                  }),
                  shape: Border(top: BorderSide(color: Colors.black, width: 2)),
                  tileColor: selectedIndex == index
                      ? Colors.grey[200]
                      : Colors.transparent,
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(chatUsers[index].imageURL),
                        // maxRadius: 35,
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
                  title: Text(chatUsers[index].name),
                  subtitle: Text(chatUsers[index].messageText),
                  trailing: Text(chatUsers[index].time),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}