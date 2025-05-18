import 'package:aloha_mobile/atoms/scrolling_text.dart';
import 'package:aloha_mobile/screens/home.dart';
import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;

  const IconTile({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(item.icon),
            const SizedBox(width: 10),
            Expanded(
              child: ScrollingText(
                text:item.text,
                style: TextStyle(fontSize: 18),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
