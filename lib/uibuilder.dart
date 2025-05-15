import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class ChecklistWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ChecklistWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return CheckboxListTile(
          value: item['meta']['checked'] ?? false,
          onChanged: null,
          title: SelectableText(item['content'] ?? ''),
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }
}

class DelimiterWidget extends StatelessWidget {
  const DelimiterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(LucideIcons.asterisk),
        Icon(LucideIcons.asterisk),
        Icon(LucideIcons.asterisk),
      ],
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final double height;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.borderRadius = 12,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: height,
                width: double.infinity,
                color: Colors.white,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            height: height,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Icon(Icons.broken_image, size: 48),
          ),
        ),
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  final String text;
  final int level;

  const HeadingWidget({super.key, required this.text, this.level = 1});

  @override
  Widget build(BuildContext context) {
    final fontSizes = {1: 40.0, 2: 35.0, 3: 30.0, 4: 25.0, 5: 20.0, 6: 15.0};

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: fontSizes[level.clamp(1, 6)]!,
        ),
      ),
    );
  }
}

class RecursiveListWidget extends StatelessWidget {
  final List<dynamic> items;
  final bool ordered;
  final int indentLevel;

  const RecursiveListWidget({
    super.key,
    required this.items,
    this.ordered = false,
    this.indentLevel = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Padding(
          padding: EdgeInsets.only(left: 16.0 * indentLevel, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ordered ? '${index + 1}.' : '•', style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item['content'] ?? '', style: const TextStyle(fontSize: 16))),
                ],
              ),
              if (item['items'] != null && item['items'].isNotEmpty)
                RecursiveListWidget(
                  items: List<Map<String, dynamic>>.from(item['items']),
                  ordered: ordered,
                  indentLevel: indentLevel + 1,
                ),
            ],
          ),
        );
      }),
    );
  }
}

class UIBuilder extends StatelessWidget {
  final Map<String, dynamic> json;

  const UIBuilder({super.key, required this.json});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> blocks = json['blocks'].skip(1).toList();

    List<Widget> widgetList = blocks.map<Widget>((block) {
      final type = block['type'];
      final data = block['data'];

      switch (type) {
        case 'header':
          return HeadingWidget(
            text: data['text'] ?? '',
            level: data['level'],
          );
        case 'delimiter':
          return const DelimiterWidget();
        case 'image':
          return ImageWidget(imageUrl: data['file']['url']);
        case 'paragraph':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(data['text'] ?? '', style: const TextStyle(fontSize: 16)),
          );
        case 'list':
          return RecursiveListWidget(
            items: List<Map<String, dynamic>>.from(data['items']),
            ordered: data['style'] == 'ordered',
          );
        case 'checklist':
          return ChecklistWidget(
            items: List<Map<String, dynamic>>.from(data['items']),
          );
        default:
          return const SizedBox.shrink();
      }
    }).toList();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: widgetList,
    );
  }
}
