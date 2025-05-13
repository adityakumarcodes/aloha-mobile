import 'dart:convert';

import 'package:aloha_mobile/home.dart';
import 'package:aloha_mobile/icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  List data = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future _fetchTasks() async {
    final response = await Supabase.instance.client.from('notes').select();
    setState(() => data = response);
  }

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
            data.isEmpty
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: ListTile(
                        title: Text(
                          data[index]['title'],
                          style: TextStyle(
                            fontSize: 20,
                            decoration:
                                data[index]['ststus_flag'] == 'active'
                                    ? TextDecoration.lineThrough
                                    : null,
                            decorationThickness: 3,
                          ),
                        ),
                        leading: const Icon(LucideIcons.asterisk),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // shape: Border.all(color: Colors.black, width: 2),
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
                                          children: [
                                            const Icon(
                                              LucideIcons.chevronUp,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                            Text(
                                              data[index]['title']??'',
                                              style: const TextStyle(
                                                fontSize: 35,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              DateFormat.yMMMd()
                                                  .add_jm()
                                                  .format(
                                                    DateTime.parse(
                                                      data[index]['createdOn'],
                                                    ),
                                                  ),
                                            ),
                                            const SizedBox(height: 15),
                                            SelectableText(
                                              jsonEncode(
                                                data[index]['content'],
                                              ),
                                              style: const TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                            const SizedBox(height: 40),
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
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
