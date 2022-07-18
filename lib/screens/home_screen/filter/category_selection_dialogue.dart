import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/filter_bloc.dart';
import 'bloc/filter_event.dart';

class CategorySelectionDialogue extends StatefulWidget {
  const CategorySelectionDialogue({
    Key? key,
  }) : super(key: key);

  @override
  State<CategorySelectionDialogue> createState() =>
      _CategorySelectionDialogueState();
}

class _CategorySelectionDialogueState extends State<CategorySelectionDialogue> {
  List<PurchaseCategory> categories = [];

  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<FilterBloc>(context);
    List<Widget> categoriesWidgets = [];

    BlocProvider.of<CategoriesBloc>(context)
        .state
        .categories
        .forEach((key, value) {
      categoriesWidgets.add(
        CheckboxListTile(
          value: _bloc.state.settings.isCategorySelected(value),
          onChanged: (newValue) {
            if (newValue!) {
              categories.add(value);
              _bloc.add(
                CategoryChanged(categories: categories),
              );
            } else {
              categories.remove(value);
              _bloc.add(
                CategoryChanged(categories: categories),
              );
            }
            setState(() {});
          },
          title: Text(value.name),
        ),
      );
    });
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categoriesWidgets,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _bloc.add(CategoryChanged(categories: null));
                Navigator.of(context).pop();
              },
              child: const Text('all'),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            )
          ],
        ),
      ),
    );
  }
}
