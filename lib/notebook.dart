import 'dart:convert';

import 'package:aloha_mobile/constants.dart';
import 'package:aloha_mobile/home.dart';
import 'package:aloha_mobile/icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

final List<CategoryItem> folderList = [
  CategoryItem(icon: LucideIcons.folder, text: 'Home', route: '/home'),
  CategoryItem(icon: LucideIcons.folder, text: 'Work', route: '/work'),
  CategoryItem(icon: LucideIcons.folder, text: 'Code', route: '/code'),
  CategoryItem(icon: LucideIcons.folder, text: 'Play', route: '/play'),
];

class _NotebookPageState extends State<NotebookPage> {
  final TextEditingController _folderController = TextEditingController();

  @override
  void dispose() {
    _folderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text('Notebook'),
        centerTitle: true,
        elevation: 2,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
        actions: [
          IconButton(
            tooltip: 'New Folder',
            icon: const Icon(LucideIcons.folderPlus),
            onPressed: () => _dialogBuilder(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    folderList.map((item) {
                      return IconTile(
                        item: item,
                        onTap:
                            () => context.push('/notebook/folder${item.route}'),
                      );
                    }).toList(),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: taskItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    title: Text(taskItems[index]['title']),
                    leading: const Icon(LucideIcons.asterisk),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    tileColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        clipBehavior: Clip.hardEdge,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            minChildSize: 0.2,
                            maxChildSize: 1,
                            expand: false,
                            builder:
                                (_, controller) => SingleChildScrollView(
                                  controller: controller,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          taskItems[index]['title'],
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                        ),
                                        const SizedBox(height: 8),
                                        ..._renderSubtitle(
                                          taskItems[index]['subtitle'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 30),
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
            onPressed: () => context.push('/notebook/addTask'),
            tooltip: 'Add Task',
            heroTag: "fab2",
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
                    folderList.add(
                      CategoryItem(
                        icon: LucideIcons.folder,
                        text: folderName,
                        route: '/home',
                      ),
                    );
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

List<Widget> _renderSubtitle(dynamic subtitle) {
   if (subtitle is String) {
    return [Text(subtitle)];
  }else if (subtitle is Map && subtitle.containsKey('blocks')) {
    return List<Widget>.from(
      subtitle['blocks'].map<Widget>((block) {
        final type = block['type'];
        final data = block['data'];

        switch (type) {
          case 'header':
            final text = data?['text'] ?? '';
            final level = data?['level'] ?? 4;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: (24 - level.clamp(1, 6) * 2).toDouble(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          case 'delimiter':
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(LucideIcons.asterisk),
                  Icon(LucideIcons.asterisk),
                  Icon(LucideIcons.asterisk),
                ],
              ),
            );
          default:
            return const SizedBox.shrink(); // skip unknown types
        }
      }),
    );
  } else {
    return [Text(jsonEncode(subtitle))]; // fallback if format is unexpected
  }
}
