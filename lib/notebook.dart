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
  final TextEditingController _folderController = TextEditingController();

  @override
  void dispose() {
    _folderController.dispose();
    super.dispose();
  }

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
                bool isEven = folderList.length % 2 == 0;
                bool isLast = index == folderList.length - 1;
                bool isSecondLast = index == folderList.length - 2;

                bool removeBottomBorder =
                    isEven ? (isLast || isSecondLast) : isLast;
                return InkWell(
                  onTap: () {
                    final folderName = folderList[index];
                    context.push('/notebook/folder/$folderName');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        // left:
                        //     index.isOdd
                        //         ? const BorderSide(
                        //           color: Colors.black,
                        //           width: 1,
                        //         )
                        //         : BorderSide.none,
                        right:
                            index.isEven
                                ? const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )
                                : BorderSide.none,
                        bottom:
                            removeBottomBorder
                                ? BorderSide.none
                                : const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_rounded,
                          size: 50.0,
                          color: Colors.blue[600],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          folderList[index].toUpperCase(),
                          style: const TextStyle(fontSize: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  child: ListTile(
                    title: Text(item['title'] ?? 'Title'),
                    leading: const Icon(LucideIcons.stickyNote),
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
            onPressed: () {},
            tooltip: 'Calender',
            heroTag: "fab1",
            child: Icon(LucideIcons.calendarDays),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _dialogBuilder(context),
            tooltip: 'New folder',
            heroTag: "fab2",
            child: Icon(LucideIcons.folderPlus),
          ),
          SizedBox(height: 10),
          FloatingActionButton.large(
            onPressed: () => context.push('/notebook/addTask'),
            tooltip: 'Add Task',
            heroTag: "fab3",
            child: Icon(LucideIcons.plus),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    _folderController.clear();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New folder'),
          content: TextField(
            controller: _folderController,
            decoration: const InputDecoration(
              hintText: 'Enter folder name',
              border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Create'),
              onPressed: () {
                final folderName = _folderController.text.trim();
                if (folderName.isNotEmpty) {
                  setState(() {
                    folderList.add(folderName);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
