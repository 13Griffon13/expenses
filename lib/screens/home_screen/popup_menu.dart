import 'package:finances/screens/categories_screen/categories_screen.dart';
import 'package:finances/screens/help_screen.dart';
import 'package:flutter/material.dart';

enum MenuItems { categories, help}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItems>(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: MenuItems.categories,
            child: const Text('Categories manager'),
            onTap: () {},
          ),
          PopupMenuItem(
            value: MenuItems.help,
            child: const Text('Help'),
            onTap: () {},
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case MenuItems.categories:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return const CategoriesScreen();
              }),
            );
            break;
          case MenuItems.help:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const HelpScreen();
              }),
            );
            break;
        }
      },
    );
  }
}
