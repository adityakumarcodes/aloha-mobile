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
                        onTap: () => context.push(item.route),
                      );
                    }).toList(),
              ),
            ),
            // GridView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: folderList.length,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: 3,
            //   ),
            //   itemBuilder: (context, index) {
            //     bool isEven = folderList.length % 2 == 0;
            //     bool isLast = index == folderList.length - 1;
            //     bool isSecondLast = index == folderList.length - 2;

            //     // bool removeBottomBorder =
            //     // isEven ? (isLast || isSecondLast) : isLast;
            //     return InkWell(
            //       onTap: () {
            //         final folderName = folderList[index];
            //         context.push('/notebook/folder/$folderName');
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(
            //           border: Border(
            //             right:
            //                 index.isEven
            //                     ? const BorderSide(
            //                       color: Colors.black,
            //                       width: 2,
            //                     )
            //                     : BorderSide.none,
            //             bottom: const BorderSide(color: Colors.black, width: 2),
            //           ),
            //         ),
            //         child: Row(
            //           // mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Icon(
            //                 Icons.folder_rounded,
            //                 size: 40,
            //                 color: Colors.blue[600],
            //               ),
            //             ),
            //             const SizedBox(height: 6),
            //             Text(
            //               folderList[index].text,
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //               style: Theme.of(context).textTheme.bodyLarge,
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // ListView.builder(
            // separatorBuilder:
            //     (context, index) => Container(
            //       decoration: BoxDecoration(
            //         border: Border(
            //           top: BorderSide(color: Colors.black, width: 2),
            //         ),
            //       ),
            //     ),
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: taskItems.length,
            //   itemBuilder: (context, index) {
            //     final item = taskItems[index];
            //     return ListTile(
            //       title: Text(
            //         item['title'] ?? 'Title',
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //         // style: Theme.of(context).textTheme.bodyLarge,
            //       ),
            //       leading: Icon(LucideIcons.stickyNote),
            //       onTap: () {},
            //     );
            //   },
            // ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) { 
                  return Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10
                      ),
                      child: ListTile(
                        title: Text(
                          taskItems[index].title,
                          // document['task'],
                          // style: TextStyle(
                          //   // color: Colors.white,
                          //   // fontSize: 20,
                          //   // decoration: document['completed']
                          //   // ? TextDecoration.lineThrough
                          //   // : null,
                          //   // decorationThickness: 3,
                          // ),
                        ),
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
                                        // child: Message(document: document),
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
                        onLongPress: () {
                          // firestoreServices.toggleCompleted(document);
                        },
                      ),
                    );
               },
              // children:
              //     ).toList(),
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
