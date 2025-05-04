// ignore_for_file: unused_import

import 'package:aloha_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class ChatDetails extends StatefulWidget {
  final ChatUsers user;

  const ChatDetails({super.key, required this.user});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var friendProvider = context.watch<FriendProvider>();
    ChatUsers user = chatUsers[friendProvider.friendSelectedToChat];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(
        //     LucideIcons.arrowLeft,
        //     // color: Colors.white,
        //   ),
        //   tooltip: 'Back',
        // ),
        flexibleSpace: Row(
          children: <Widget>[
            const SizedBox(width: 50),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(user.imageURL),
                maxRadius: 25,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if ((friendProvider.friendSelectedToChat % 3 == 0) == false)
                    const Text(
                      "Online",
                      style: TextStyle(fontSize: 13),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.video),
            tooltip: 'Video call',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.phone),
            tooltip: 'Voice call',
          ),
          PopupMenuButton<String>(
            // offset: const Offset(-40, 0),
            tooltip: 'More options',
            enableFeedback: true,
            icon: const Icon(LucideIcons.ellipsisVertical),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onSelected: handleClick,
            itemBuilder: (context) {
              return {
                'View profile',
                'Search',
                'Mute notifications',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // MESSAGE LIST SECTION
          SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, bottom: 75),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                    left: messages[index].messageType == "receiver" ? 14 : 60,
                    right:
                        messages[index].messageType == "receiver" ? 60 : 14,
                    top: 6,
                    bottom: 6,
                  ),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade300
                                : Theme.of(context).primaryColor),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  (messages[index].messageType == "receiver"
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                        Text(
                          "${DateTime.now().hour}:${DateTime.now()
                                  .minute
                                  .toString()
                                  .padLeft(2, "0")}",
                          // style: const TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // BOTTOM TEXT BOX
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: kElevationToShadow[3],
              ),
              margin: const EdgeInsets.only(left: 5, bottom: 10, right: 5),
              // height: 60,
              constraints: const BoxConstraints(minHeight: 60),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  // const SizedBox(width: 15),
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        context: context,
                        constraints: const BoxConstraints(maxWidth: 500),
                        builder: (context) {
                          return const Text('EMoijs');
                        },
                      );
                    },
                  ),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Write a message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 15),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.paperclip,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        context: context,
                        constraints: const BoxConstraints(maxWidth: 500),
                        builder: (context) {
                          return Column(
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircularIconButton(
                                    label: 'Document',
                                    icon: LucideIcons.file,
                                    color: Colors.purple,
                                    onPress: () {},
                                  ),
                                  CircularIconButton(
                                    label: 'Camera',
                                    icon: Icons.photo_camera,
                                    color: Colors.red,
                                    onPress: () {},
                                  ),
                                  CircularIconButton(
                                    label: 'Gallery',
                                    icon: LucideIcons.image,
                                    color: Colors.pink,
                                    onPress: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircularIconButton(
                                    label: 'Audio',
                                    icon: LucideIcons.headphones,
                                    color: Colors.orange,
                                    onPress: () {},
                                  ),
                                  CircularIconButton(
                                    label: 'Location',
                                    icon: LucideIcons.pin,
                                    color: Colors.green,
                                    onPress: () {},
                                  ),
                                  CircularIconButton(
                                    label: 'Contact',
                                    icon: LucideIcons.user,
                                    color: Colors.blue,
                                    onPress: () {},
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      endDrawer: ClipRRect(
        // borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: Drawer(
            // width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      currentAccountPicture: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          user.imageURL,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      // curve: Curves.bounceOut,
                      // child: Text('Drawer Header'),
                      // decoration: const BoxDecoration(
                      //   color: Colors.redAccent,
                      // ),
                      accountEmail: const Text('ak19992017@gmail.com'),
                      accountName: Text(user.name),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(LucideIcons.paperclip),
                        title: const Text('Media, links and docs'),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.block),
                        title: const Text('Block '),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.thumb_down),
                        title: const Text('Report'),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(LucideIcons.trash2),
                        title: const Text('Delete chat'),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'View profile':
        {
          _scaffoldKey.currentState!.openEndDrawer();
          break;
        }
      default:
        break;
    }
  }
}



class CircularIconButton extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final void Function()? onPress;
  const CircularIconButton({
    super.key,
    required this.color,
    required this.label,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          margin: const EdgeInsets.all(20),
          height: 60,
          width: 60,
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            onPressed: onPress,
          ),
        ),
        Text(label)
      ],
    );
  }
}