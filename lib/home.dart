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
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(LucideIcons.bookOpen),
              title: Text('Notebook'),
              onTap: () {
                Navigator.of(context).pop();
                context.push('/notebook');
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.messageSquare),
              title: Text('Chat'),
              onTap: () {
                Navigator.of(context).pop();
                context.push('/chat');
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.pyramid),
              title: Text('Social'),
              onTap: () {
                Navigator.of(context).pop();
                context.push('/social');
              },
            ),
            ListTile(
              leading: Icon(LucideIcons.bolt),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                context.push('/settings');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(LucideIcons.search),
      ),
    );
  }
}
