import 'package:aloha_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FolderList extends StatelessWidget {
  final String folderName;

  const FolderList({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          folderName,
          style: const TextStyle(fontSize: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        elevation: 2,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: taskItems.length,
        itemBuilder: (context, index) {
          final item = taskItems[index];
          return ListTile(
            title: Text(item['title'] ?? 'Title'),
            leading: const Icon(LucideIcons.stickyNote),
            onTap: () {},
          );
        },
        separatorBuilder:
            (context, index) => Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black, width: 2)),
              ),
            ),
      ),
    );
  }
}
