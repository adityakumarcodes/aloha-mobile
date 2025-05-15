import 'package:flutter/material.dart';

class ScrollingTextItem extends StatefulWidget {
  final String text;
  const ScrollingTextItem({super.key, required this.text});

  @override
  State<ScrollingTextItem> createState() => _ScrollingTextItemState();
}

class _ScrollingTextItemState extends State<ScrollingTextItem> with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  int scrollCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrollIfNeeded();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _startScrollIfNeeded() async {
    final containerWidth = context.size?.width ?? 0;
    final textWidth = _getTextWidth(widget.text);

    if (textWidth > containerWidth) {
      await Future.delayed(const Duration(seconds: 2));

      final scrollAmount = textWidth - containerWidth;

      while (scrollCount < 2 && mounted) {
        await scrollController.animateTo(
          scrollAmount,
          duration: const Duration(seconds: 4),
          curve: Curves.linear,
        );

        await Future.delayed(const Duration(seconds: 1));

        await scrollController.animateTo(
          0,
          duration: const Duration(seconds: 4),
          curve: Curves.linear,
        );

        await Future.delayed(const Duration(seconds: 1));

        scrollCount++;
      }
    }
  }

  double _getTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 18)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Text(widget.text, style: const TextStyle(fontSize: 18)),
    );
  }
}
