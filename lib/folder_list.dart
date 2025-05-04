import 'package:flutter/material.dart';

class FolderList extends StatelessWidget {
  final String folderName;

  const FolderList({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_rounded, size: 30, color: Colors.blue[600]),
            const SizedBox(height: 8.0),
            Text(
              folderName.toUpperCase(),
              style: const TextStyle(fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 2,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 1.6,
        child: Image.asset('assets/profiles/image.png',width:400)),
    );
  }
}
