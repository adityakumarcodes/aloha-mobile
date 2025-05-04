import 'package:aloha_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  List<String> folderList = ["Home", "Work", "Code", "Play"];

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

                // bool removeBottomBorder =
                    // isEven ? (isLast || isSecondLast) : isLast;
                return InkWell(
                  onTap: () {
                    final folderName = folderList[index];
                    context.push('/notebook/folder/$folderName');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right:
                            index.isEven
                                ? const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )
                                : BorderSide.none,
                        bottom:
                             const BorderSide(
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
                          size: 40,
                          color: Colors.blue[600],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          folderList[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.separated(
              separatorBuilder:
                  (context, index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskItems.length,
              itemBuilder: (context, index) {
                final item = taskItems[index];
                return ListTile(
                  title: Text(
                          item['title'] ?? 'Title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                  leading:Icon(LucideIcons.stickyNote),
                  onTap: () {},
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
            FilledButton(
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
