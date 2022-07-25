import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_state.dart';
import 'package:finances/screens/home_screen/list_of_records/list_of_record_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfRecords extends StatelessWidget {
  const ListOfRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListOfRecordsBloc, ListOfRecordsState>(
      bloc: BlocProvider.of<ListOfRecordsBloc>(context),
      builder: (BuildContext context, state) {
        switch (state.status) {
          case ListOfRecordsStatus.success:
            List<Widget> items = [];
            double sum = 0;
            var categories = BlocProvider.of<CategoriesBloc>(context).state;
            state.records?.forEach((element) {
              sum = sum + element.sum;
              items.add(ListOfRecordsElement(
                record: element,
                category: categories.getCategoryById(element.categoryId),
              ));
            });
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                  ),
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text('Total: $sum'),
                ),
                Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      gradient: LinearGradient(
                        colors: [Colors.white30, Colors.grey],
                        stops: [0.0, 0.7],
                      )),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: items,
                    ),
                  ),
                ),
              ],
            );
          case ListOfRecordsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ListOfRecordsStatus.error:
            return const Center(child: Icon(Icons.error));
          case ListOfRecordsStatus.initial:
            return const Center(
              child: Text('Initialization'),
            );
        }
      },
    );
  }
}
