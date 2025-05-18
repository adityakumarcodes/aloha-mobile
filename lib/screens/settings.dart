import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
