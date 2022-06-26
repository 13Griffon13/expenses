import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/categories_bloc/categories_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<FilterBloc>(context);
    List<Widget> categories = [];

    for (var element
        in BlocProvider.of<CategoriesBloc>(context).state.categories) {
      categories.add(TextButton(
        onPressed: () {
          // _bloc.add(CategoryChanged(categories: element));
          Navigator.of(context).pop();
        },
        child: Text(element.name),
      ));
    }
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categories,
              ),
            ),
            const Spacer(),
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
