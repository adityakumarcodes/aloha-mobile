import 'package:aloha_mobile/chips.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _task = TextEditingController();
  final TextEditingController _description = TextEditingController();
  List<String> folderList = ["home", "work", "code", "play"];
  final List<Map<String,dynamic>> lucideIcons = [
  {'icon': LucideIcons.heading1, 'label': 'Heading 1'},
  {'icon': LucideIcons.heading2, 'label': 'Heading 2'},
  {'icon': LucideIcons.heading3, 'label': 'Heading 3'},
  {'icon': LucideIcons.heading4, 'label': 'Heading 4'},
  {'icon': LucideIcons.heading5, 'label': 'Heading 5'},
  {'icon': LucideIcons.heading6, 'label': 'Heading 6'},
  {'icon': LucideIcons.bold, 'label': 'Bold'},
  {'icon': LucideIcons.italic, 'label': 'Italic'},
  {'icon': LucideIcons.square, 'label': 'Todo'},
  {'icon': LucideIcons.image, 'label': 'Image'},
  {'icon': LucideIcons.paperclip, 'label': 'Attachment'},
];

  bool _completed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        elevation: 2,
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter title here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      controller: _task,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 30.0),                    
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter description here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      controller: _description,
                      minLines: 6,
                      maxLines: 18,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
                Switch(
                  value: _completed,
                  onChanged: (value) => setState(() => _completed = value),
                ),
                IconButtonList( labeledIcons: lucideIcons ),
                const SizedBox(height: 30.0),                    
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text(
                      'ADD TASK',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
