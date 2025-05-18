import 'package:flutter/material.dart';

class MyDrivePage extends StatefulWidget {
  const MyDrivePage({super.key});

  @override
  State<MyDrivePage> createState() => _MyDrivePageState();
}

class _MyDrivePageState extends State<MyDrivePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Drive'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Center(
        child: Text('My Drive'),
      ),
    );
  }
}
