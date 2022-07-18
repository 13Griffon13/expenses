import 'package:finances/screens/categories_screen/add_category_dialog.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_state.dart';
import 'package:finances/screens/categories_screen/category_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Categories"),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<CategoriesBloc>(context),
        builder: (BuildContext context, CategoriesState state) {
          List<Widget> categoriesWidgets = [];
          state.categories.forEach((key, value) {
            categoriesWidgets.add(CategoryElement(category: value));
          });
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: categoriesWidgets,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddCategoryDialog();
              });
        },
      ),
    );
  }
}
