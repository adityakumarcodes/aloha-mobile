import 'package:flutter/material.dart';

class IconButtonList extends StatelessWidget {
  final List<Map<String, dynamic>> labeledIcons;

  const IconButtonList({super.key, required this.labeledIcons});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: labeledIcons.map((item) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: IconButton(
            icon: Icon(item['icon'],size: 30),
            onPressed: () {},
            tooltip: item['label'],
          ),
        );
      }).toList(),
    );
  }
}
