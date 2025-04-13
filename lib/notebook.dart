import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  final List<Map<String, String>> items = [
    {'title': 'Item 1', 'subtitle': 'Description 1'},
    {'title': 'Item 2', 'subtitle': 'Description 2'},
    {'title': 'Item 3', 'subtitle': 'Description 3'},
    {'title': 'Item 4', 'subtitle': 'Description 4'},
    {'title': 'Item 5', 'subtitle': 'Description 5'},
    {'title': 'Item 6', 'subtitle': 'Description 6'},
    {'title': 'Item 7', 'subtitle': 'Description 7'},
    {'title': 'Item 8', 'subtitle': 'Description 8'},
    {'title': 'Item 9', 'subtitle': 'Description 9'},
    {'title': 'Item 10', 'subtitle': 'Description 10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notebook'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
            decoration:BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2)),),
            child: ListTile(
              title: Text(item['title'] ?? 'Title'),
              leading: const Icon(LucideIcons.zap),
              onTap: () {},
              trailing: Icon(Icons.more_horiz),
            ),
          );
        },
       
      ),
    );
  }
}
