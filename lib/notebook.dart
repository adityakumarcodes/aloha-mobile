import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  List<String> folderList = ["home", "work", "code", "play"];
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: folderList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        folderList[index].toUpperCase(),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(top:BorderSide(color: Colors.black, width: 2)),
                  ),      
                  child: ListTile(
                    title: Text(item['title'] ?? 'Title'),
                    leading: const Icon(LucideIcons.zap),
                    trailing: Icon(LucideIcons.ellipsisVertical),
                    onTap: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _dialogBuilder(context),
            tooltip: 'Add folder',
            heroTag: "fab1",
            child: Icon(LucideIcons.folderPlus),
          ),
          SizedBox(height: 10),
          FloatingActionButton.large(
            onPressed: () {
              context.push('/notebook/addTask');
            },
            tooltip: 'Add Task',
            heroTag: "fab2",
            child: Icon(LucideIcons.plus),
          ),
        ],
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add folder'),
        content: const Text('Name of the folder'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
