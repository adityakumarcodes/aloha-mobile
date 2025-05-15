import 'package:aloha_mobile/home.dart';
import 'package:aloha_mobile/notebook.dart';
import 'package:aloha_mobile/uibuilder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FolderList extends StatefulWidget {
  final String folderName;

  const FolderList({super.key, required this.folderName});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  final TextEditingController _folderController = TextEditingController();

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final response = await Supabase.instance.client
        .from('notes')
        .select()
        .like('category', widget.folderName.toLowerCase())
        .order('id');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: Text(
          widget.folderName.toUpperCase(),
          style: const TextStyle(fontSize: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text(
                'Empty Folder',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final note = data[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(
                    note['title'] ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      decoration: note['status_flag'] == 'active'
                          ? TextDecoration.lineThrough
                          : null,
                      decorationThickness: 2,
                    ),
                  ),
                  leading: const Icon(LucideIcons.asterisk),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2),
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
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.5,
                          minChildSize: 0.2,
                          maxChildSize: 1,
                          expand: false,
                          builder: (_, controller) => SingleChildScrollView(
                            controller: controller,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const Icon(
                                  LucideIcons.chevronUp,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                Text(
                                  note['title'] ?? '',
                                  style: const TextStyle(fontSize: 35),
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  DateFormat.yMMMd().add_jm().format(
                                    DateTime.parse(note['createdOn']),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                // SelectableText(
                                //   jsonEncode(note['content']),
                                //   style: const TextStyle(fontSize: 25),
                                // ),
                                UIBuilder(json: data[index]['content']),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: NotebookFab(),
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
