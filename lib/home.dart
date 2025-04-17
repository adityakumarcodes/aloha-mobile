import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<String> _routes = [
    '/',
    '/notebook',
    '/chat',
    '/social',
    '/settings',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Integrate taskmaster'),
            Text('Integrate chatmaster'),
            Text('Add auth'),
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: <Widget>[
      //       DrawerHeader(child: Center(child: Text('Aloha'))),
      //       ListTile(
      //         leading: Icon(LucideIcons.house),
      //         title: Text('Home'),
      //         onTap: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(LucideIcons.bookOpen),
      //         title: Text('Notebook'),
      //         onTap: () {
      //           Navigator.of(context).pop();
      //           context.push('/notebook');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(LucideIcons.messageSquare),
      //         title: Text('Chat'),
      //         onTap: () {
      //           Navigator.of(context).pop();
      //           context.push('/chat');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(LucideIcons.pyramid),
      //         title: Text('Social'),
      //         onTap: () {
      //           Navigator.of(context).pop();
      //           context.push('/social');
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(LucideIcons.bolt),
      //         title: Text('Settings'),
      //         onTap: () {
      //           Navigator.of(context).pop();
      //           context.push('/settings');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() => _selectedIndex = index);
          Navigator.pop(context);
          context.push(_routes[index]);
          
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Aloha'),
          ),
          Divider(),
          const NavigationDrawerDestination(
            icon: Icon(LucideIcons.house),
            selectedIcon: Icon(
              LucideIcons.house,
            ), // Optional: Define specific selected icon
            label: Text('Home'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(LucideIcons.bookOpen),
            selectedIcon: Icon(
              LucideIcons.bookOpen,
            ), // Optional: Define specific selected icon
            label: Text('Notebook'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(LucideIcons.messageSquare),
            label: Text('Chat'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(LucideIcons.pyramid),
            label: Text('Social'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(LucideIcons.bolt),
            label: Text('Settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        child: Icon(LucideIcons.search),
      ),
    );
  }
}
