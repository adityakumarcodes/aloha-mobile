import 'package:aloha_mobile/atoms/icon_tile.dart';
import 'package:aloha_mobile/atoms/wordoftheday.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CategoryItem {
  final IconData icon;
  final String text;
  final String route;

  CategoryItem({required this.icon, required this.text, required this.route});
}

final List<CategoryItem> categoriesList = [
  CategoryItem(icon: LucideIcons.bookOpen,text: 'Notebook',route: '/notebook'),
  CategoryItem(icon: LucideIcons.messageCircleMore,text: 'Chat',route: '/chat'),
  CategoryItem(icon: LucideIcons.hardDrive,text: 'My Drive',route: '/mydrive'),
  CategoryItem(icon: LucideIcons.pyramid, text: 'Social', route: '/social'),
  CategoryItem(icon: LucideIcons.shoppingBag, text: 'Shop', route: '/shop'),
  CategoryItem(icon: LucideIcons.calendar, text: 'Calendar', route: '/calendar'),
  CategoryItem(icon: LucideIcons.bolt, text: 'Settings', route: '/settings')
];

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text(''),
        // centerTitle: true,
        // elevation: 2,
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: WordOfTheDay(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,8,8),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    categoriesList.map((item) {
                      return IconTile(
                        item: item,
                        onTap: () => context.push(item.route),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        child: Icon(LucideIcons.search),
      ),
    );
  }
}
