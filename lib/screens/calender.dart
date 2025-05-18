import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Center(
        child: Text('Calendar'),
      ),
    );
  }
}
