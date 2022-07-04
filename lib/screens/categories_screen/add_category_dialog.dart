import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddCategoryDialog extends StatelessWidget {
  AddCategoryDialog({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add new category"),
      content: TextField(
        controller: controller,
        maxLines: 1,
      ),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<CategoriesBloc>(context).add(
              CategoriesAdded(
                category: PurchaseCategory(
                    id: const Uuid().v1(), name: controller.text),
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        )
      ],
    );
  }
}
