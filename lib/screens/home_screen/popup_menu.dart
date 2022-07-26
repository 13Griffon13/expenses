import 'package:finances/screens/authorization/bloc/auth_bloc.dart';
import 'package:finances/screens/authorization/bloc/auth_event.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:finances/screens/categories_screen/categories_screen.dart';
import 'package:finances/screens/help_screen.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_bloc.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_event.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuItems { categories, help, signOut }

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItems>(
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: MenuItems.categories,
            child: Text('Categories manager'),
          ),
          PopupMenuItem(
            value: MenuItems.help,
            child: Text('Help'),
          ),
          PopupMenuItem(
            value: MenuItems.signOut,
            child: Text('Sign Out'),
          )
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
          case MenuItems.signOut:
            BlocProvider.of<ListOfRecordsBloc>(context).add(ResetList());
            BlocProvider.of<CategoriesBloc>(context).add(ResetCategories());
            BlocProvider.of<FilterBloc>(context).add(ResetFilters());
            BlocProvider.of<AuthBloc>(context).add(AuthSignOut());
            break;
        }
      },
    );
  }
}
