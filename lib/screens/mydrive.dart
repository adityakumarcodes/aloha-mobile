import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MyDrivePage extends StatefulWidget {
  const MyDrivePage({super.key});

  @override
  State<MyDrivePage> createState() => _MyDrivePageState();
}

class _MyDrivePageState extends State<MyDrivePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Drive'),
        centerTitle: true,
        elevation: 2,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
        actions: [
          IconButton(
            tooltip: 'New Folder',
            icon: const Icon(LucideIcons.folderPlus), onPressed: () {  },
            // onPressed: () => _dialogBuilder(context),
          ),
        ],
      ),
      body: Center(
        child: Text('My Drive'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(LucideIcons.cloudUpload),
            ),
            Text('Upload'),
          ],
        ),
      ),
    );
  }
}
