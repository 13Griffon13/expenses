import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/add_record_screen.dart';
import 'package:finances/screens/categories_bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'filter/filter_widget.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const FilterWidget(),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return AddRecordScreen(
                  record: PurchaseRecord(
                    id: const Uuid().v1(),
                    sum: 100.0,
                    date: DateTime.now(),
                    category: BlocProvider.of<CategoriesBloc>(context)
                        .state
                        .categories
                        .first,
                  ),
                );
              }),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
