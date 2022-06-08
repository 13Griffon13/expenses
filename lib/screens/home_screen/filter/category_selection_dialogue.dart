import 'package:finances/model/purchase_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/filter_bloc.dart';
import 'bloc/filter_event.dart';

class CategorySelectionDialogue extends StatefulWidget {
  const CategorySelectionDialogue({Key? key,}) : super(key: key);

  @override
  State<CategorySelectionDialogue> createState() => _CategorySelectionDialogueState();
}

class _CategorySelectionDialogueState extends State<CategorySelectionDialogue> {
  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<FilterBloc>(context);
    List<Widget> categories = [];
    for (var element in PurchaseTypes.values) {
      categories.add(TextButton(
        onPressed: () {
          _bloc.add(CategoryChanged(type: element));
          Navigator.of(context).pop();
        },
        child: Text(element.name),
      ));
    }

    categories.add(TextButton(
      onPressed: () {
        _bloc.add(CategoryChanged(type: null));
        Navigator.of(context).pop();
      },
      child: const Text('all'),
    ));
    categories.add(IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    ));
    return Dialog(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: categories,
            ),
          ),
        ],
      ),
    );
  }
}
