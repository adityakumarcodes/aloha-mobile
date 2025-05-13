import 'dart:convert';

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
  List data = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future _fetchTasks() async {
    final response = await Supabase.instance.client
        .from('notes')
        .select()
        .like('category', widget.folderName.toLowerCase())
        .order('id');
    setState(() => data = response);
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
        // shape: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body:
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
                              data[index]['status_flag'] == 'active'
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
                                            data[index]['title'] ?? '',
                                            style: const TextStyle(
                                              fontSize: 35,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            DateFormat.yMMMd().add_jm().format(
                                              DateTime.parse(
                                                data[index]['createdOn'],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          SelectableText(
                                            jsonEncode(data[index]['content']),
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
    );
  }
}
