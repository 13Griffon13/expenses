import 'package:finances/global_widgets/interactive_list_item.dart';
import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryElement extends StatelessWidget {
  const CategoryElement({Key? key, required this.category}) : super(key: key);

  final PurchaseCategory category;

  @override
  Widget build(BuildContext context) {
    return InteractiveListItem(
      height: 50.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            gradient: const LinearGradient(colors: [
              Colors.blueGrey,
              Colors.white54,
              Colors.white,
              Colors.white54,
              Colors.blueGrey
            ], stops: [
              0.0,
              0.4,
              0.5,
              0.6,
              1.0
            ])),
        child: Center(child: Text(category.name)),
      ),
      onDelete: () {
        BlocProvider.of<CategoriesBloc>(context)
            .add(CategoriesDeleted(category: category));
      },
      onEdit: () {},
    );
  }
}
